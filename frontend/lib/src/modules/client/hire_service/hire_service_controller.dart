import 'package:get/get.dart';
import 'package:rings/src/core/models/client.dart';
import 'package:rings/src/core/models/service_type.dart';
import 'package:rings/src/modules/client/hire_service/services/hire_service_service.dart';
import 'package:rings/src/shared/widgets/success_dialog.dart';

class HireServiceController extends GetxController {
  final Client _client;
	final _service = HireServiceService();

	HireServiceController(this._client);

	Client get client => _client;

	final _filteredServices = Rx<List<ServiceType>>(ServiceType.values);
	List<ServiceType> get filteredServices => _filteredServices.value;

	final _loading = Rx<bool>(false);
	final _error = Rx<String?>(null);

	bool get isLoading => _loading.value;
	bool get hasError => _error.value != null;
	String? get error => _error.value;

	bool serviceIsHired(ServiceType serviceType) {
		for (final account in client.accounts) {
			for (final service in account.services) {
				if (service.serviceType == serviceType) {
					return service.isHired;
				}
			}
		}
		return false;
	}

	void search(String search) {
		search = search.toLowerCase();
		_filteredServices.value = ServiceType.values
			.where((type) {
				return type.name.toLowerCase().contains(search) ||
							 type.toString().split('.')[1].toLowerCase().contains(search);
			})
			.toList();
	}

	Future<void> hireService(ServiceType serviceType) async {
		_error.value = null;
		_loading.value = true;
		final result = await _service.hireService(client, serviceType);

		_loading.value = false;
		result.fold(
			(failure) => _error.value = failure.message,
			(data) {
				if (data) {
					Get.dialog(SuccessDialog(onPressed: () {
						Get.offAllNamed('/home');
					}));
				}
			}
		);
	}

	Future<void> unhireService(ServiceType serviceType) async {
		_error.value = null;
		_loading.value = true;
		final result = await _service.unhireService(client, serviceType);

		_loading.value = false;
		result.fold(
			(failure) => _error.value = failure.message,
			(data) {
				if (data) {
					Get.dialog(SuccessDialog(onPressed: () {
						Get.offAllNamed('/home');
					}));
				}
			}
		);
	}

}