import 'package:rings/src/core/models/service_type.dart';

export 'package:rings/src/core/models/service_type.dart';

class Service {
	
	late final int _id;
	late final String _name;
	late final int _tax;
	late final DateTime _hiredAt;
	late DateTime? _canceledAt;
	late final int? _value;
	late final DateTime? _dueAt;
	late final String? _insurance;
	late final ServiceType _serviceType;
	late final int _accountId;
	late final DateTime _createdAt;

	Service.fromJson(Map json) {
		_id = json['id'];
		_name = json['name'];
		_tax = json['tax'];
		_value = json['value'];
		_insurance = json['insurance'];
		_serviceType = (json['type'] as String).serviceFromName;
		print(_serviceType);

		_accountId = json['account_id'];
		_dueAt = DateTime.tryParse(json['due_at'] ?? '')?.toLocal();
		_canceledAt = DateTime.tryParse(json['canceled_at'] ?? '')?.toLocal();
		_hiredAt = DateTime.parse(json['hired_at']).toLocal();
		_createdAt = DateTime.parse(json['created_at']).toLocal();
	}

	int get id => _id;
	String get name => _name;
	int get tax => _tax;
	DateTime get hiredAt => _hiredAt;
	DateTime? get canceledAt => _canceledAt;
	int? get value => _value;
	DateTime? get dueAt => _dueAt;
	String? get insurance => _insurance;
	ServiceType get serviceType => _serviceType;
	int get accountId => _accountId;
	DateTime get createdAt => _createdAt;

	bool get isHired => _hiredAt != null && _canceledAt == null;

}