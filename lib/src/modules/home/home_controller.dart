import 'package:get/state_manager.dart';
import 'package:rings/src/modules/home/models/employee.dart';
import 'package:rings/src/modules/home/services/home_service.dart';

class HomeController extends GetxController {

	final HomeService _service = HomeService();

	final _employees = Rx<List<Employee>?>(null);

	bool get hasData => _employees.value != null;
	List<Employee>? get data => _employees.value;

	@override
	void onInit() async {
		super.onInit();
		_employees.bindStream(await _service.getData());
	}

	@override
  void onReady() {
		_service.getEmployees().then((value) => _employees.value = value);
    super.onReady();
  }

	@override
  void onClose() async {
    super.onClose();
  }

}