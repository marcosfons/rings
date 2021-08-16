import 'package:get/get.dart';
import 'package:rings/src/core/models/client.dart';

class HireServiceController extends GetxController {
  final Client _client;

	HireServiceController(this._client);

	Client get client => _client;

}