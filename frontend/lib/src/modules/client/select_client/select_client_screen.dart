import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rings/src/modules/client/select_client/select_client_controller.dart';
import 'package:rings/src/modules/client/select_client/widgets/client_tile.dart';

class SelectClientScreen extends StatelessWidget {
	const SelectClientScreen({ Key? key }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final controller = Get.find<SelectClientController>();

		return Scaffold(
			appBar: AppBar(
				title: Text(
					'Selecionar cliente',
					style: TextStyle(
						color: Colors.black,
						fontWeight: FontWeight.bold
					),
				),
			),
			body: Column(
				children: [
					Container(
						padding: const EdgeInsets.only(
							left: 24, right: 24,
							top: 18,
							bottom: 12
						),
						child: TextField(
							decoration: InputDecoration(
								hintText: 'CPF, CNPJ ou nome completo',
								suffixIcon: Icon(Icons.search),
							),
							autofocus: true,
							onChanged: controller.search,
						),
					),
					const Divider(height: 0,),
					Expanded(
						child: Obx(() {
							if (controller.hasError) {
								return Center(
								  child: Column(
								  	mainAxisSize: MainAxisSize.min,
										children: [
											Text(
												'Ocorreu um erro',
												style: TextStyle(
													fontSize: 18,
													fontWeight: FontWeight.w600
												),
											),
											const SizedBox(height: 2,),
											
											if (controller.error != null)
												Text(controller.error!),

											const SizedBox(height: 14,),

											ElevatedButton(
												onPressed: controller.loadClients,
												child: Padding(
												  padding: const EdgeInsets.symmetric(
														horizontal: 10,
														vertical: 8
													),
												  child: Text('Tentar novamente'),
												),
											)
										],
								  ),
								);
							}

							if (controller.hasData) {
								return ListView.separated(
									itemCount: controller.filteredClients!.length + 1,
									itemBuilder: (ctx, index) {
										if (index == controller.filteredClients!.length) return const SizedBox();
										return ClientTile(client: controller.filteredClients![index]);
									},
									separatorBuilder: (ctx, index) {
										return const Divider(height: 0,);
									},
								);
							}

							return Center(child: CircularProgressIndicator(),);
						})
					),
				],
			),
		);
	}
}