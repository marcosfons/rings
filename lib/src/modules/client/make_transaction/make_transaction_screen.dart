import 'dart:math';

import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rings/src/modules/client/make_transaction/make_transaction_controller.dart';
import 'package:rings/src/modules/client/sign_up_client/widgets/cancel_confirm_box.dart';
import 'package:rings/src/modules/client/sign_up_client/widgets/custom_input.dart';

class MakeTransactionScreen extends StatefulWidget {
  const MakeTransactionScreen({Key? key}) : super(key: key);

  @override
  _MakeTransactionScreenState createState() => _MakeTransactionScreenState();
}

class _MakeTransactionScreenState extends State<MakeTransactionScreen> {
  String _value = 'Boleto';

  List<String> fields = [
    'Valor',
    'Nome completo',
    'CPF',
    'CNPJ',
    'Nome do banco',
    'Número da agência',
    'Número da conta',
  ];

  final inputFormatters = <String, List<TextInputFormatter>>{
    'CPF': [
      TextInputMask(mask: ['999.999.999-99'])
    ],
    'CNPJ': [
      TextInputMask(mask: ['99.999.999/9999-99'])
    ],
    'Número da agência': [
      TextInputMask(mask: ['999'])
    ],
    'Número da conta': [
      TextInputMask(mask: ['9999999-9'])
    ],
  };

  final isNumeric = ['CPF', 'CNPJ', 'Número da agência', 'Número da conta'];

  Widget _chooseInputs() {
    switch (_value) {
      case 'Transferência':
        return Expanded(
          child: ScrollConfiguration(
            behavior: NoGlowEffect(),
            child: ListView.separated(
              padding: const EdgeInsets.all(15),
              // shrinkWrap: true,
              itemCount: fields.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 15),
              itemBuilder: (BuildContext context, int index) {
                return CustomInput(
                  label: fields[index],
                  hintText: fields[index],
                  icon: Icons.edit,
                  inputFormatters: inputFormatters[fields[index]],
                  keyboardType: isNumeric.contains(fields[index])
                      ? TextInputType.number
                      : null,
                );
              },
            ),
          ),
        );
      case 'Boleto':
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                TextInputMask(
                    mask: '99999.99999 99999.99999 99999.99999 9 99999999999999')
              ],
            ),
          ),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MakeTransactionController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fazer Transação',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              controller.client.name,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
              bottom: 10,
            ),
            child: Row(
              children: [
                Text('Tipo:'),
                SizedBox(width: 20),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    icon: Transform.rotate(
                        angle: pi / 2,
                        child: Icon(
                          Icons.chevron_right,
                          size: 25,
                        )),
                    value: _value,
                    items:
                        <String>['Boleto', 'Transferência'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        if (newValue != null) _value = newValue;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          _chooseInputs(),
          CancelConfirmBox(),
        ],
      ),
    );
  }
}
