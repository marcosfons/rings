import 'package:flutter/material.dart';
import 'package:rings/src/shared/widgets/button_row.dart';

class CancelConfirmBox extends StatelessWidget {
  const CancelConfirmBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
		return ButtonRow(
			firstButtonLabel: 'Cancelar',
			secondButtonLabel: 'Confirmar',
			firstOnPressed: () {},
			secondOnPressed: () {},
		);
    // return Container(
    //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    //   child: Row(
    //     children: [
    //       Expanded(
    //         child: TextButton(
    //           style: TextButton.styleFrom(
    //             primary: Colors.black,
    //             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(10.0),
    //               side: BorderSide(color: Colors.black),
    //             ),
    //           ),
    //           onPressed: () {},
    //           child: Text("Cancelar", style: TextStyle(fontSize: 16)),
    //         ),
    //       ),
    //       const SizedBox(width: 10),
    //       Expanded(
    //         child: TextButton(
    //           style: TextButton.styleFrom(
    //             primary: Colors.white,
    //             backgroundColor: Colors.blue,
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(10.0)),
    //           ),
    //           onPressed: () {},
    //           child: Text("Confirmar", style: TextStyle(fontSize: 16)),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
