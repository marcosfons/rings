import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
	const ButtonRow({ 
		Key? key, 
		required this.firstButtonLabel, 
		required this.secondButtonLabel, 
		required this.firstOnPressed, 
		required this.secondOnPressed,
		
	}) : super(key: key);

	final String firstButtonLabel;
	final String secondButtonLabel;
	final Function() firstOnPressed;
	final Function() secondOnPressed;

	static const _buttonPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 18);

	@override
	Widget build(BuildContext context) {
		return Padding(
		  padding: const EdgeInsets.symmetric(
				horizontal: 10,
				vertical: 8
			),
		  child: ConstrainedBox(
				constraints: BoxConstraints(maxWidth: 440),
				child: Row(
					children: [
						Expanded(
							child: ElevatedButton(
								onPressed: firstOnPressed,
								child: Text(
									firstButtonLabel,
									style: TextStyle(fontWeight: FontWeight.bold),
								),
								style: ElevatedButton.styleFrom(
									primary: Colors.white,
									onPrimary: Colors.black,
									padding: _buttonPadding,
									shape: const RoundedRectangleBorder(
										borderRadius: BorderRadius.all(Radius.circular(10)),
										side: BorderSide(color: Colors.black, width: 2)
									)
								)
							),
						),
						const SizedBox(width: 14,),
						Expanded(
							child: ElevatedButton(
								onPressed: secondOnPressed,
								child: Text(secondButtonLabel),
								style: ElevatedButton.styleFrom(padding: _buttonPadding)
							),
						)
					],
				),
			),
		);
	}
}