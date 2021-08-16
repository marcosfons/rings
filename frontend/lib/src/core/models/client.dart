class Client {

	late final int id;
	late String name;
	late String cpf;
	late String? cnpj;
	late String nickname;
	late String email;
	late String address;
	late String occupation;
	late String phone;
	late String? addressReceiptImage;
	late String? profitReceiptImage;
	late DateTime updatedAt;
	late DateTime createdAt;

	Client.fromJson(Map json) {
		id = json['id'];
		name = json['name'];
		cpf = json['cpf'];
		cnpj = json['cnpj'];
		nickname = json['nickname'];
		email = json['email'];
		address = json['address'];
		occupation = json['occupation'];
		phone = json['phone'];
		addressReceiptImage = json['address_receipt_image'];
		profitReceiptImage = json['profit_receipt_image'];
		updatedAt = DateTime.parse(json['updated_at']).toLocal();
		createdAt = DateTime.parse(json['created_at']).toLocal();
	}

}