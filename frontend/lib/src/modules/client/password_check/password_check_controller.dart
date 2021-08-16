import 'package:get/state_manager.dart';
import 'package:rings/src/modules/client/models/client.dart';

class PasswordCheckController extends GetxController {
  final Client _client;

  PasswordCheckController(this._client);

  Client get client => _client;
}
