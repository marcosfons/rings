

import 'package:flutter/material.dart';

const _inputBorder = OutlineInputBorder(
	borderRadius: BorderRadius.all(Radius.circular(12)),
	borderSide: BorderSide(width: 0, color: Colors.transparent),
);

final lightTheme = ThemeData(
	primaryColor: Color(0xff0068FF),
	brightness: Brightness.light,
	appBarTheme: AppBarTheme(
		backgroundColor: Colors.white,
		centerTitle: true,
		elevation: 2,
		iconTheme: IconThemeData(
			color: Colors.black
		),
	),

	elevatedButtonTheme: ElevatedButtonThemeData(
		style: ButtonStyle(
			backgroundColor: MaterialStateProperty.all(Color(0xff0068FF)),
			shape: MaterialStateProperty.all(
				const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
			)
		)
	),

	buttonColor: Colors.green,

	inputDecorationTheme: InputDecorationTheme(
		focusedBorder: _inputBorder,
		border: _inputBorder,
		enabledBorder: _inputBorder,
		fillColor: Color(0xffececec),
		filled: true,
	)
);