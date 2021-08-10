

import 'package:flutter/material.dart';

const _inputBorder = OutlineInputBorder(
	borderRadius: BorderRadius.all(Radius.circular(12)),
	borderSide: BorderSide(width: 0, color: Colors.transparent),
);

final lightTheme = ThemeData(
	brightness: Brightness.light,
	appBarTheme: AppBarTheme(
		backgroundColor: Colors.white,
		centerTitle: true,
		elevation: 2,
		iconTheme: IconThemeData(
			color: Colors.black
		),
	),

	inputDecorationTheme: InputDecorationTheme(
		focusedBorder: _inputBorder,
		border: _inputBorder,
		enabledBorder: _inputBorder,
		fillColor: Color(0xffececec),
		filled: true,
	)
);