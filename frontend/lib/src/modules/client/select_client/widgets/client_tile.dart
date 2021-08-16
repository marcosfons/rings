import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rings/src/core/models/client.dart';

class ClientTile extends StatelessWidget {
	final Client client;

	const ClientTile({ 
		Key? key, 
		required this.client 
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return ListTile(
			title: Text(
				client.name,
				style: TextStyle(
					fontSize: 20
				),
			),
			subtitle: Text(client.nickname),
			onTap: () {
				Get.toNamed(
					'/new_operation/${client.id}',
					arguments: client,
				);
			},
			trailing: Icon(
				Icons.chevron_right,
				size: 30,
			),
		);
	}
}