import 'package:rings/src/modules/home/models/employee.dart';

class SignInData {

	late final int employeeId;
	late final String token;
	late final Employee employee;

	SignInData.fromJson(Map json) {
		employeeId = json['employee_id'];
		token = json['token'];
		employee = Employee.fromJson(json['employee']);
	}
}