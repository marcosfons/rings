import 'package:flutter/material.dart';
import 'package:rings/src/modules/client/sign_up_client/widgets/cancel_confirm_box.dart';
import 'package:rings/src/modules/client/sign_up_client/widgets/custom_input.dart';

class SignUpClientScreen extends StatelessWidget {
  const SignUpClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> fields = [
      'Nome completo',
      'CPF/CNPJ',
      'Apelido',
      'E-mail',
      'Telefone'
    ];

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
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15),
                itemBuilder: (BuildContext context, int index) {
                  return CustomInput(label: fields[index], icon: Icons.edit);
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