import 'package:get/get.dart';
import 'package:rings/src/core/controllers/auth_controller.dart';
import 'package:rings/src/modules/auth/sign_in/services/sign_in_service.dart';

class SignInController extends GetxController {

	final _signInService = SignInService();

	String _email = '';
	String _password = '';
	
	final _loading = Rx<bool>(false);
	final _error = Rx<String?>(null);

	bool get isLoading => _loading.value;
	bool get hasError => _error.value != null;
	String? get error => _error.value;

	set email(String email) => _email = email;
	set password(String password) => _password = password;

	Future<void> signIn() async {
		_error.value = null;
		_loading.value = true;
		final result = await _signInService.signIn(_email, _password);

		_loading.value = false;
		result.fold(
			(failure) => _error.value = failure.message,
			(data) {
				print(data.token);
				Get.put(AuthController(data), permanent: true);
				Get.offNamed('/home');
			}
		);
	}

}