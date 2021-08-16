import 'package:flutter/material.dart';
import 'package:rings/src/core/models/account.dart';
import 'package:rings/src/modules/client/view_data/widgets/client_field_line.dart';

class AccountDataSection extends StatelessWidget {
	const AccountDataSection({ Key? key, required this.account }) : super(key: key);

	final Account account;

	@override
	Widget build(BuildContext context) {
		final accountType = account.type == 'savings'
			? 'Poupança'
			: 'Corrente';

		return Column(
			mainAxisSize: MainAxisSize.min,
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Text(
					'Conta $accountType',
					style: TextStyle(
						fontSize: 18,
						fontWeight: FontWeight.bold
					),
				),
				ClientFieldLine(
					fieldName: 'Número da conta',
					fieldValue: account.number,
				),
				ClientFieldLine(
					fieldName: 'Agência',
					fieldValue: account.agency.number,
				),
				ClientFieldLine(
					fieldName: 'Cidade',
					fieldValue: account.agency.city,
				),
				ClientFieldLine(
					fieldName: 'Estado',
					fieldValue: account.agency.state,
				)
			]
		);
	}
}