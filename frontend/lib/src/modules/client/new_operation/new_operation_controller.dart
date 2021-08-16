import 'package:get/state_manager.dart';
import 'package:rings/src/core/models/client.dart';

class NewOperationController extends GetxController {

	final Client _client;

	NewOperationController(this._client);

	Client get client => _client;

}