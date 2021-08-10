import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rings/src/modules/client/new_operation/new_operation_controller.dart';

class NewOperationScreen extends StatelessWidget {
	const NewOperationScreen({ Key? key }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final controller = Get.find<NewOperationController>();

		return Scaffold(
			appBar: AppBar(
				foregroundColor: Colors.red,
				title: Text(
					'Nova operação',
					style: TextStyle(
						color: Colors.black,
						fontWeight: FontWeight.bold
					),
				),
			),
			body: Column(
				children: [
					Text(controller.client.name)
				],
			),
		);
	}
}