import 'package:get/get.dart';
import 'package:rings/src/core/services/hasura/hasura_client.dart';
import 'package:rings/src/modules/auth/sign_in/sign_in_screen.dart';
import 'package:rings/src/modules/client/new_operation/new_operation_controller.dart';
import 'package:rings/src/modules/client/new_operation/new_operation_screen.dart';
import 'package:rings/src/modules/client/select_client/select_client_controller.dart';
import 'package:rings/src/modules/client/select_client/select_client_screen.dart';
import 'package:rings/src/modules/home/home_controller.dart';
import 'package:rings/src/modules/home/home_screen.dart';

abstract class Routes {

	static final List<GetPage> pages = [
		GetPage(
			name: '/', 
			page: () => SignInScreen()
		),
		GetPage(
			name: '/home', 
			page: () => HomeScreen(),
			binding: BindingsBuilder(() {
				Get.lazyPut(() => HomeController());
			})
		),
		GetPage(
			name: '/select_client', 
			page: () => SelectClientScreen(),
			binding: BindingsBuilder(() {
				Get.lazyPut(() => HasuraClient());
				Get.lazyPut(() => SelectClientController());
			})
		),
		GetPage(
			name: '/new_operation/:clientId', 
			page: () => NewOperationScreen(),
			binding: BindingsBuilder(() {
				Get.lazyPut(() => NewOperationController(Get.arguments));
			})
		),
	];

}