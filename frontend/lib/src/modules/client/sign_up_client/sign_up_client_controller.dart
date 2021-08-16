import 'package:get/get.dart';
import 'package:rings/src/modules/client/sign_up_client/services/sign_up_client_service.dart';
import 'package:rings/src/shared/widgets/success_dialog.dart';

import 'models/field.dart';

class SignUpClientController extends GetxController {

	final _service = SignUpClientService();

	final _error = Rx<String?>(null);

	bool get hasError => _error.value != null;
	String? get error => _error.value;

	Future<void> createClientFromFields(List<Field> fields) async {
		_error.value = null;
		final result = await _service.createClient(fields);
		
		result.fold(
			(failure) => _error.value = failure.message,
			(client) {
				Get.dialog(SuccessDialog(onPressed: () {
					Get.offAllNamed('/home');
				}));
			}
		);
	}

}