import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rings/src/modules/client/hire_service/hire_service_controller.dart';
import 'package:rings/src/modules/client/models/service.dart';
import 'package:rings/src/modules/client/sign_up_client/widgets/custom_input.dart';

class HireServiceScreen extends StatelessWidget {
  const HireServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HireServiceController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contratar Serviço',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              controller.client.name,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 12,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Nome do serviço',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                print(value);
              },
            ),
          ),
          const Divider(height: 0),
          ScrollConfiguration(
            behavior: NoGlowEffect(),
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 0),
              itemCount: ServiceType.values.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: Container(
                    padding:
                        const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        Expanded(child: Text(ServiceType.values[index].name)),
                        Icon(Icons.check),
                      ],
                    ),
                  ),
                  onTap: () {},
                );
              },
            ),
          ),
          const Divider(height: 0),
        ],
      ),
    );
  }
}
