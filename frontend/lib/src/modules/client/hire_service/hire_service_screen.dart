import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rings/src/modules/client/hire_service/hire_service_controller.dart';
import 'package:rings/src/modules/client/sign_up_client/widgets/custom_input.dart';
import 'package:rings/src/core/models/service_type.dart';

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
				actions: [
					Obx(() {
						if (controller.isLoading)
							return Padding(
							  padding: const EdgeInsets.only(right: 12),
							  child: const Center(
							  	child: SizedBox(
							  		width: 18,
							  		height: 18,
							  		child: CircularProgressIndicator(strokeWidth: 1,)
							  	),
							  ),
							);
						return const SizedBox();
					})
				],
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
              onChanged: controller.search,
            ),
          ),
					Obx(() {
						if (controller.hasError) {
							return Padding(
							  padding: const EdgeInsets.only(bottom: 12),
							  child: Text(controller.error!),
							);
						}
						return const SizedBox();
					}),
          const Divider(height: 0),
          ScrollConfiguration(
            behavior: NoGlowEffect(),
            child: Expanded(
              child: Obx(() => ListView.separated(
                separatorBuilder: (context, index) => const Divider(height: 0),
                itemCount: controller.filteredServices.length + 1,
                itemBuilder: (context, index) {
                  if (index == controller.filteredServices.length) return SizedBox();
									final currentService = controller.filteredServices[index];
									final isHired = controller.serviceIsHired(currentService);

                  return InkWell(
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          Expanded(child: Text(currentService.name)),
                          if (isHired)
														Icon(Icons.check),
                        ],
                      ),
                    ),
                    onTap: () {
											if (isHired) {
												controller.unhireService(currentService);
											} else {
												controller.hireService(currentService);
											}
										}
                  );
                },
              )),
            ),
          ),
        ],
      ),
    );
  }
}
