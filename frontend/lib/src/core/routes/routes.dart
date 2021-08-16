import 'package:get/get.dart';
import 'package:rings/src/core/routes/middlewares/signed_in_middleware.dart';
import 'package:rings/src/modules/auth/sign_in/sign_in_controller.dart';
import 'package:rings/src/modules/auth/sign_in/sign_in_screen.dart';
import 'package:rings/src/modules/client/hire_service/hire_service_controller.dart';
import 'package:rings/src/modules/client/hire_service/hire_service_screen.dart';
import 'package:rings/src/modules/client/make_transaction/make_transaction_controller.dart';
import 'package:rings/src/modules/client/make_transaction/make_transaction_screen.dart';
import 'package:rings/src/modules/client/new_operation/new_operation_controller.dart';
import 'package:rings/src/modules/client/new_operation/new_operation_screen.dart';
import 'package:rings/src/modules/client/select_client/select_client_controller.dart';
import 'package:rings/src/modules/client/select_client/select_client_screen.dart';
import 'package:rings/src/modules/client/sign_up_client/sign_up_client_controller.dart';
import 'package:rings/src/modules/client/sign_up_client/sign_up_client_screen.dart';
import 'package:rings/src/modules/home/home_controller.dart';
import 'package:rings/src/modules/home/home_screen.dart';

abstract class Routes {

	static final List<GetPage> pages = [
		GetPage(
			name: '/sign_in', 
			page: () => SignInScreen(),
			binding: BindingsBuilder(() {
				Get.lazyPut(() => SignInController());
			})
		),
		GetPage(
			name: '/home', 
			page: () => HomeScreen(),
			middlewares: [ SignedInMiddleware() ],
			binding: BindingsBuilder(() {
				Get.lazyPut(() => HomeController());
			})
		),
		GetPage(
			name: '/select_client', 
			page: () => SelectClientScreen(),
			binding: BindingsBuilder(() {
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
    GetPage(
      name: '/sign_up_client',
      page: () => SignUpClientScreen(),
			binding: BindingsBuilder(() {
				Get.lazyPut(() => SignUpClientController());
			})
    ),
    GetPage(
        name: '/hire_service/:clientId',
        page: () => HireServiceScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => HireServiceController(Get.arguments));
        })),
    GetPage(
      name: '/make_transaction/:clientId',
      page: () => MakeTransactionScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MakeTransactionController(Get.arguments));
      })),
  ];
}
