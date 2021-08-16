import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:rings/src/core/controllers/auth_controller.dart';

class HasuraAuthInterceptor extends InterceptorBase {
  @override
  Future<Request> onRequest(Request request) async {
		try {
			final authController = Get.find<AuthController>();
			if (authController.isSignedIn) {
				request.headers['Authorization'] = 'Bearer ${authController.token}';
			}
			
			return request;
		} catch(e) {
			return request;
		}
  }
}
