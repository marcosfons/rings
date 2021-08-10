import 'package:get/get.dart';
import 'package:rings/src/modules/auth/sign_in/sign_in_screen.dart';
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
	];

}