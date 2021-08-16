import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rings/src/modules/client/sign_up_client/widgets/cancel_confirm_box.dart';
import 'package:rings/src/modules/client/sign_up_client/widgets/custom_input.dart';

class SignUpClientScreen extends StatelessWidget {
  const SignUpClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> fields = [
      'Nome completo',
      'CPF',
      'CNPJ',
      'Apelido',
      'E-mail',
      'Telefone'
    ];

    final inputFormatters = <String, List<TextInputFormatter>>{
      'CPF': [
        TextInputMask(mask: ['999.999.999-99'])
      ],
      'CNPJ': [
        TextInputMask(mask: ['99.999.999/9999-99'])
      ],
      'Telefone': [
        TextInputMask(mask: ['\\+99 (99) 99999-9999'])
      ]
    };

    final isNumeric = ['CPF', 'CNPJ', 'Telefone'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastrar Cliente',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
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
          ),
          CancelConfirmBox(),
        ],
      ),
    );
  }
}
