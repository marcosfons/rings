import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
	const SuccessDialog({ Key? key, required this.onPressed }) : super(key: key);

	final Function() onPressed;

	@override
	Widget build(BuildContext context) {
		return AlertDialog(
			title: Text('Sucesso'),
			content: Text('Operação realizada com sucesso'),
			actions: [
				ElevatedButton(
					onPressed: onPressed,
					child: Text('Continuar'),
				)
			],
		);
	}
}