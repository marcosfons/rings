import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rings/src/modules/client/view_data/view_data_controller.dart';
import 'package:rings/src/modules/client/view_data/widgets/account_data_section.dart';
import 'package:rings/src/modules/client/view_data/widgets/client_field_line.dart';

class ViewDataScreen extends StatelessWidget {
	const ViewDataScreen({ Key? key }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final controller = Get.find<ViewDataController>();

		return Scaffold(
			appBar: AppBar(
				title: Text(
          'Visualizar dados',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
			),
			body: ListView(
				padding: const EdgeInsets.symmetric(horizontal: 30),
				children: [
					Container(
						alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Text(
              controller.client.name,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
					const SizedBox(height: 20,),
					...controller.client.accounts
						.map((account) => AccountDataSection(account: account))
						.toList(),

					const SizedBox(height: 20,),
					Text(
						'Dados pessoais',
						style: TextStyle(
							fontSize: 18,
							fontWeight: FontWeight.bold
						),
					),
					ClientFieldLine(
						fieldName: 'Apelido',
						fieldValue: controller.client.nickname,
					),
					ClientFieldLine(
						fieldName: 'CPF',
						fieldValue: controller.client.cpf,
					),
					if (controller.client.cnpj != null)
						ClientFieldLine(
							fieldName: 'CNPJ',
							fieldValue: controller.client.cnpj!,
						),
					
					ClientFieldLine(
						fieldName: 'E-mail',
						fieldValue: controller.client.email,
					),
					ClientFieldLine(
						fieldName: 'Telefone',
						fieldValue: controller.client.phone,
					),
					ClientFieldLine(
						fieldName: 'Profissão',
						fieldValue: controller.client.occupation,
					),
					ClientFieldLine(
						fieldName: 'Endereço',
						fieldValue: controller.client.address,
					)
				],
			),
		);
	}
}