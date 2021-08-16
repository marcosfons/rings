import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rings/src/core/controllers/auth_controller.dart';
import 'package:rings/src/modules/home/home_controller.dart';
import 'package:rings/src/shared/widgets/button_row.dart';

class HomeScreen extends StatelessWidget {
	const HomeScreen({ Key? key }) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		final authController = Get.find<AuthController>();
		final controller = Get.find<HomeController>();

		return Scaffold(
			appBar: AppBar(
				centerTitle: false,
				title: Column(
					mainAxisSize: MainAxisSize.min,
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text(
							authController.employee.name,
							style: TextStyle(
								fontSize: 20,
								color: Colors.black,
								fontWeight: FontWeight.w600
							),
						),
						Text(
							'Funcionário',
							style: TextStyle(
								fontSize: 14,
								fontWeight: FontWeight.bold,
								color: Colors.grey
							),
						)
					],
				),
				actions: [
					IconButton(
						onPressed: () {
							Get.delete<AuthController>(force: true);
							Get.offNamed('/sign_in');
						},
						icon: Icon(Icons.exit_to_app),						
					)
				],
			),
			body: Column(
				crossAxisAlignment: CrossAxisAlignment.center,
				children: [
					Padding(
					  padding: const EdgeInsets.only(top: 16, bottom: 8),
					  child: ButtonRow(
							firstButtonLabel: 'Cadastrar cliente',
							firstOnPressed: () => Get.toNamed('/sign_up_client'),
							secondButtonLabel: 'Operação para cliente',
							secondOnPressed: () => Get.toNamed('/select_client'),
						),
					),
					Expanded(
						child: ListView.builder(
							itemCount: 0,
							itemBuilder: (ctx, index) {
								return SizedBox();
							},
						),
					)
				],
			)
		);
	}
}