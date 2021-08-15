import 'package:flutter/material.dart';

class CancelConfirmBox extends StatelessWidget {
  const CancelConfirmBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.black),
                ),
              ),
              onPressed: () {},
              child: Text("Cancelar"),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              onPressed: () {},
              child: Text("Confirmar"),
            ),
          )
        ],
      ),
    );
  }
}
