import 'package:get/get.dart';
import 'package:rings/src/core/models/client.dart';

class MakeTransactionController extends GetxController {
  final Client _client;

	MakeTransactionController(this._client);

	Client get client => _client;

}