import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rings/src/modules/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
	const HomeScreen({ Key? key }) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		final controller = Get.find<HomeController>();

		return Scaffold(
			appBar: AppBar(
				title: Text('HomeScreen'),
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
				return Center(child: CircularProgressIndicator(),);
			})
		);
	}
}