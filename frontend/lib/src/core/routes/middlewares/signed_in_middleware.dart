import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rings/src/core/controllers/auth_controller.dart';

class SignedInMiddleware extends GetMiddleware {
	
	@override
	RouteSettings? redirect(String? route) {
		try {
			final _authController = Get.find<AuthController>();
			if (!_authController.isSignedIn) {
				return null;
			}
			
			Get.delete<AuthController>(force: true);
			return RouteSettings(
				name: '/'
			);
		} catch(e) {
			return null;
		}
	}

}
