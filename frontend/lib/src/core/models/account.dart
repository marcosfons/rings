import 'package:rings/src/core/models/agency.dart';
import 'package:rings/src/core/models/service.dart';

class Account {

	late final int _id;
	late final int _balance;
	late final String _number;
	late final String _type;
	late final int _clientId;
	late final Agency _agency;
	late final List<Service> _services;
	late final DateTime _updatedAt;
	late final DateTime _createdAt;

	Account.fromJson(Map json) {
		_id = json['id'];
		_balance = json['balance'];
		_number = json['number'];
		_type = json['type'];
		_clientId = json['client_id'];
		_agency = Agency.fromJson(json['agency']);
		_updatedAt = DateTime.parse(json['updated_at']).toLocal();
		_createdAt = DateTime.parse(json['created_at']).toLocal();

		_services = (json['services'] as List)
			.map((serviceJson) => Service.fromJson(serviceJson))
			.toList();
	}

	int get id => _id;
	int get balance => _balance;
	String get number => _number;
	String get type => _type;
	int get clientId => _clientId;
	Agency get agency => _agency;
	List<Service> get services => _services;
	DateTime get updatedAt => _updatedAt;
	DateTime get createdAt => _createdAt;

}