import 'package:get/state_manager.dart';
import 'package:rings/src/core/models/client.dart';
import 'package:rings/src/modules/client/select_client/services/select_client_service.dart';

class SelectClientController extends GetxController {

	final SelectClientService _selectClientsService;
	
  SelectClientController(this._selectClientsService);

	final _clients = Rx<List<Client>?>(null);
	final _filteredClients = Rx<List<Client>?>(null);
	final _error = Rx<String?>(null);

	bool get isLoading => _clients.value == null && _error.value == null;
	bool get hasError => _error.value != null;
	bool get hasData => _clients.value != null;

	String? get error => _error.value;
	List<Client>? get filteredClients => _filteredClients.value;

	@override
	void onReady() {
		super.onReady();
		loadClients();
	}

	Future<void> loadClients() async {
		_reset();
		final result = await _selectClientsService.getClients();

		result.fold(
			(failure) => _error.value = failure.message, 
			(clients) {
				_clients.value = clients;
				_filteredClients.value = clients;
			}
		);
	}

	void search(String search) {
		search = search.toLowerCase();
		_filteredClients.value = _clients.value!
			.where((client) {
				return client.name.toLowerCase().contains(search) ||
							 client.cpf.contains(search) ||
							 (client.cnpj?.contains(search) ?? false);
			})
			.toList();
	}

	void _reset() {
		_error.value = null;
		_clients.value = null;
	}

}