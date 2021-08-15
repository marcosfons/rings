class Client {

	late final int _id;
	late final String _name;
	late final String _nickname;
	late final String _cpf;
	late final String? _cnpj;
	late final String _email;
	late final String _address;
	late final String _occupation;
	late final String _phone;
	late final String _addressReceiptImage;
	late final String _profitReceiptImage;
	late final DateTime _updatedAt;
	late final DateTime _createdAt;

	Client.fromJson(Map json) {
		_id = json['id'];
		_name = json['name'];
		_nickname = json['nickname'];
		_cpf = json['cpf'];
		_cnpj = json['cnpj'];
		_email = json['email'];
		_address = json['address'];
		_occupation = json['occupation'];
		_phone = json['phone'];
		_addressReceiptImage = json['address_receipt_image'];
		_profitReceiptImage = json['profit_receipt_image'];
		_updatedAt = DateTime.parse(json['updated_at']).toLocal();
		_createdAt = DateTime.parse(json['created_at']).toLocal();
	}

	int get id => _id;
	String get name => _name;
	String get nickname => _nickname;
	String get cpf => _cpf;
	String? get cnpj => _cnpj;
	String get email => _email;
	String get address => _address;
	String get occupation => _occupation;
	String get phone => _phone;
	String get addressReceiptImage => _addressReceiptImage;
	String get profitReceiptImage => _profitReceiptImage;
	DateTime get updatedAt => _updatedAt;
	DateTime get createdAt => _createdAt;

}