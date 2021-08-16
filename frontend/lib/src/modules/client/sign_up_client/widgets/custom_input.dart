import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NoGlowEffect extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class CustomInput extends StatelessWidget {
  final String label;
  final IconData? icon;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
	final Function(String)? onChanged;

  const CustomInput(
		{Key? key,
		required this.label,
		this.icon,
		this.hintText,
		this.inputFormatters,
		this.keyboardType,
		this.onChanged
	}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, bottom: 4),
          child: Text(
            label,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
        TextField(
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
					onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: Icon(icon),
          ),
        ),
      ],
    );
  }
}
