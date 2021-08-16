import 'package:get/state_manager.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rings/src/modules/auth/sign_in/models/sign_in_data.dart';
import 'package:rings/src/modules/home/models/employee.dart';

class AuthController extends GetxController {

	late final String _authToken;
	late final DateTime _expirationTime;
	late final Rx<Employee> _employee;

	AuthController(SignInData signInData) {
		_authToken = signInData.token;
		_employee = Rx(signInData.employee);
		_expirationTime = JwtDecoder.getExpirationDate(_authToken);
	}

	Employee get employee => _employee.value;
	bool get isSignedIn => DateTime.now().isBefore(_expirationTime);
	String get token => _authToken;

}