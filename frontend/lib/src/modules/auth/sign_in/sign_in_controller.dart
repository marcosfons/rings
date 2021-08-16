import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:rings/src/core/controllers/auth_controller.dart';
import 'package:rings/src/core/failures/failure.dart';
import 'package:rings/src/core/services/hasura/hasura_client.dart';
import 'package:rings/src/modules/auth/sign_in/failures/invalid_email.dart';
import 'package:rings/src/modules/auth/sign_in/failures/invalid_password.dart';
import 'package:rings/src/modules/auth/sign_in/models/sign_in_data.dart';
import 'package:rings/src/modules/auth/sign_in/services/sign_in_service.dart';

class SignInController extends GetxController {

	final SignInService _signInService;

  SignInController(this._signInService);

	String _email = '';
	String _password = '';
	
	final _loading = Rx<bool>(false);
	final _error = Rx<String?>(null);


	bool get isLoading => _loading.value;
	bool get hasError => _error.value != null;
	String? get error => _error.value;

	set email(String email) => _email = email;
	set password(String password) => _password = password;

	Future<Either<Failure, SignInData>> signIn() async {
		_error.value = null;
		_loading.value = true;

		final validateFailure = _validateFields(_email, _password);
		if (validateFailure != null) {
			return left(validateFailure);
		}

		final result = await _signInService.signIn(_email, _password);

		_loading.value = false;
		result.fold(
			(failure) => _error.value = failure.message,
			(data) {
				Get.put(AuthController(data), permanent: true);
				Get.offNamed('/home');
			}
		);
		return result;
	}

	Failure? _validateFields(String email, String password) {
		email = email.trim();
		if (email.isEmpty ||
				!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
			return const InvalidEmailFailure();
		}

		password = password.trim();
		if (password.isEmpty || password.length < 4) {
			return const InvalidPasswordFailure();
		}
	}

}