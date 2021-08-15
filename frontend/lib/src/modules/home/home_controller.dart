import 'package:dartz/dartz.dart';
import 'package:get/state_manager.dart';
import 'package:rings/src/core/failures/failure.dart';
import 'package:rings/src/modules/home/models/employee.dart';
import 'package:rings/src/modules/home/services/home_service.dart';

class HomeController extends GetxController {

	final HomeService _service = HomeService();

	final _employees = Rx<List<Employee>?>(null);
	final _error = Rx<String?>(null);

	bool get hasData => _employees.value != null;
	List<Employee>? get data => _employees.value;

	bool get hasError => _error.value != null;
	String? get error => _error.value;

	@override
	void onInit() async {
		super.onInit();
		// _employees.bindStream(await _service.getData());
	}

	@override
  void onReady() {
		_service.getEmployees().then((Either<Failure, List<Employee>> result) {
			result.fold(
				(Failure failure) {
					_error.value = failure.message;
					_employees.value = null;
				},
				(List<Employee> employees) => _employees.value = employees
			);
		});
    super.onReady();
  }

	@override
  void onClose() async {
    super.onClose();
  }

}