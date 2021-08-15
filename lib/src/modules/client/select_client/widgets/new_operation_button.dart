import 'package:flutter/material.dart';

class NewOperationButton extends StatelessWidget {
  const NewOperationButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.only(left: 10, top: 16, bottom: 16),
          decoration: BoxDecoration(
              border: Border.all(width: 1.3, color: Color(0xFFEEEEEE)),
              borderRadius: BorderRadius.circular(8)),
          child: Row(children: [
            Icon(icon),
            const SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            )
          ]),
        ),
        onTap: onTap,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
  }
}
