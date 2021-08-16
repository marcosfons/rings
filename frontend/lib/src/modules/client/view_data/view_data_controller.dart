import 'package:get/get.dart';
import 'package:rings/src/core/models/client.dart';

class ViewDataController extends GetxController {

	final Client _client;

  ViewDataController(this._client);

	Client get client => _client;

}