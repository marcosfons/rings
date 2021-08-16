import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rings/src/modules/client/sign_up_client/models/field.dart';
import 'package:rings/src/modules/client/sign_up_client/sign_up_client_controller.dart';
import 'package:rings/src/modules/client/sign_up_client/widgets/custom_input.dart';
import 'package:rings/src/shared/widgets/button_row.dart';

class SignUpClientScreen extends StatelessWidget {
  const SignUpClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
		final controller = Get.find<SignUpClientController>();

		final List<Field> fields = [
			Field('Nome Completo', 'name'),
			Field('CPF', 'cpf', mask: '999.999.999-99', isNumeric: true),
			Field('CNPJ', 'cnpj', mask: '99.999.999/9999-99', isNumeric: true, nullable: true),
			Field('Apelido', 'nickname'),
			Field('E-mail', 'email'),
			Field('Telefone', 'phone', mask: '\\+99 (99) 99999-9999', isNumeric: true),
			Field('Profissão', 'occupation', mask: '\\+99 (99) 99999-9999', isNumeric: true),
			Field('Endereço', 'address', mask: '\\+99 (99) 99999-9999', isNumeric: true),
		];
		
		//  {
		// 	'address_receipt_image': '',
		// 	'profit_receipt_image': ''
		// }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastrar Cliente',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
					Obx(() {
						if (controller.hasError) {
							return Text(controller.error!);
						}
						return SizedBox();
					}),
          Expanded(
            child: ScrollConfiguration(
              behavior: NoGlowEffect(),
              child: ListView.separated(
                padding: const EdgeInsets.all(15),
                itemCount: fields.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 15),
                itemBuilder: (BuildContext context, int index) {
                  return CustomInput(
                    label: fields[index].name,
                    hintText: fields[index].name,
										onChanged: (text) { 
											fields[index].value = text;
										},
                    icon: Icons.edit,
                    inputFormatters: fields[index].textInputFormatter != null
											? [ fields[index].textInputFormatter! ]
											: null,
                    keyboardType: fields[index].isNumeric
                        ? TextInputType.number
                        : null,
                  );
                },
              ),
            ),
          ),
          ButtonRow(
						firstButtonLabel: 'Cancelar',
						firstOnPressed: () => Get.back(),
						secondButtonLabel: 'Confirmar',
						secondOnPressed: () => controller.createClientFromFields(fields),
					),
        ],
      ),
    );
  }
}
