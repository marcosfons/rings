import 'package:flutter/material.dart';

class ClientFieldLine extends StatelessWidget {
	const ClientFieldLine({ 
		Key? key,
		required this.fieldName,
		required this.fieldValue
	}) : super(key: key);

	final String fieldName;
	final String fieldValue;

	static const _textStyle = TextStyle(
		fontSize: 16
	);

	@override
	Widget build(BuildContext context) {
		return Padding(
		  padding: const EdgeInsets.symmetric(vertical: 6),
		  child: Row(
		  	children: [
		  		Text(
		  			'$fieldName: ',
		  			style: _textStyle,
		  		),
		  		const SizedBox(width: 10,),
		  		SelectableText(
		  			fieldValue,
		  			style: _textStyle,
		  		),
		  		const Spacer(),
		  		IconButton(
						onPressed: () {},
						icon: Icon(Icons.paste),
					)
		  	],
		  ),
		);
	}
}