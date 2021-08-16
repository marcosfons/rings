import 'package:dartz/dartz.dart';
import 'package:get/state_manager.dart';
import 'package:rings/src/core/failures/failure.dart';
import 'package:rings/src/core/models/client.dart';
import 'package:rings/src/modules/home/services/home_service.dart';

class HomeController extends GetxController {

	final HomeService _service = HomeService();

	final _clients = Rx<List<Client>?>(null);
	final _error = Rx<String?>(null);

	bool get hasData => _clients.value != null;
	List<Client>? get data => _clients.value;

	bool get hasError => _error.value != null;
	String? get error => _error.value;

	@override
	void onInit() async {
		super.onInit();
	}

	@override
  void onReady() {
		_service.getClients().then((Either<Failure, List<Client>> result) {
			result.fold(
				(Failure failure) {
					_error.value = failure.message;
					_clients.value = null;
				},
				(List<Client> clients) => _clients.value = clients
			);
		});
    super.onReady();
  }

	@override
  void onClose() async {
    super.onClose();
  }

}