import 'package:flutter/material.dart';
import 'package:rings/src/modules/client/models/client.dart';
import 'package:rings/src/modules/client/select_client/widgets/client_tile.dart';

class SelectClientScreen extends StatelessWidget {
	const SelectClientScreen({ Key? key }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final List<Client> clients = [
			Client(1, 'Frodo', 'Frodo'),
			Client(2, 'Samwise', 'Sam'),
		];

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
								hintText: 'CPF ou nome completo',
								suffixIcon: Icon(Icons.search),
							),
							onChanged: (value) {
								print(value);
							},
						),
					),
					const Divider(height: 0,),
					Expanded(
						child: ListView.separated(
							itemCount: clients.length + 1,
							itemBuilder: (ctx, index) {
								if (index == clients.length) return const SizedBox();
								return ClientTile(client: clients[index]);
							},
							separatorBuilder: (ctx, index) {
								return const Divider(height: 0,);
							},
						),
					),
				],
			),
		);
	}
}