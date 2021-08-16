import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rings/src/core/models/client.dart';
import 'package:rings/src/modules/client/new_operation/new_operation_controller.dart';
import 'package:rings/src/modules/client/select_client/widgets/new_operation_button.dart';

class NewOperationScreen extends StatelessWidget {
  const NewOperationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NewOperationController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nova operação',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(6, 6, 0, 0),
              child: Text(
                "Cliente:",
                style: TextStyle(
                    color: Color(0xAA909090),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              )),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(6, 0, 10, 6),
            child: Text(
              controller.client.name,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          NewOperationButton(
              text: "Vizualizar dados",
              icon: Icons.remove_red_eye,
              onTap: () {
                Get.toNamed(
									'/new_operation/${(Get.arguments as Client).id}/view_data',
									arguments: Get.arguments
								);
              }),
          NewOperationButton(
              text: "Atualizar dados",
              icon: Icons.edit,
              onTap: () {
                print('click Atualizar dados');
              }),
          NewOperationButton(
              text: "Fazer Transação",
              icon: Icons.attach_money,
              onTap: () {
                print('click Fazer transação');
              }),
          NewOperationButton(
              text: "Contratar serviço",
              icon: Icons.work,
              onTap: () {
								Get.toNamed(
									'/new_operation/${(Get.arguments as Client).id}/hire_service',
									arguments: Get.arguments
								);
              }),
        ],
      ),
    );
  }
}
