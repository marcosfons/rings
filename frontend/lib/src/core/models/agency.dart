class Agency {
	
	late final int _id;
	late final String _name;
	late final String _number;
	late final String _city;
	late final String _state;
	late final DateTime _createdAt;

	Agency.fromJson(Map json) {
		_id = json['id'];
		_name = json['name'];
		_number = json['number'];
		_city = json['city'];
		_state = json['state'];
		_createdAt = DateTime.parse(json['created_at']).toLocal();
	}

	int get id =>  _id;
	String get name =>  _name;
	String get number =>  _number;
	String get city =>  _city;
	String get state =>  _state;
	DateTime get createdAt =>  _createdAt;

}