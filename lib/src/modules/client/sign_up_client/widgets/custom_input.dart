import 'package:flutter/material.dart';

class NoGlowEffect extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class CustomInput extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? hintText;

  const CustomInput(
      {Key? key, required this.label, required this.icon, this.hintText})
      : super(key: key);

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
          decoration: InputDecoration(
            hintText: label,
            suffixIcon: Icon(icon),
          ),
        ),
      ],
    );
  }
}
