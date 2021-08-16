import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rings/src/core/controllers/auth_controller.dart';
import 'package:rings/src/modules/home/home_controller.dart';

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
			),
			body: Obx(() {
				if (controller.hasData) {
					return ListView.builder(
						itemCount: controller.data!.length,
						itemBuilder: (BuildContext context, int index) {
							return ListTile(
								title: Text(controller.data![index].name, style: TextStyle(fontSize: 32),),
								subtitle: Text(controller.data![index].id.toString())
							);
						},
					);
				}
				if (controller.hasError) {
					return Center(child: Text(controller.error.toString()),);
				}
				return Center(child: CircularProgressIndicator(),);
			})
		);
	}
}