

class Employee {

	late final int _id;
	late final String _name;
	late final String _image;
	late final String _email;

	int get id => _id;
	String get name => _name;
	String get image => _image;
	String get email => _email;

	Employee.fromJson(Map json) {
		_id = json['id'];
		_name = json['name'];
		_image = json['image'];
		_email = json['email'];
	}

}