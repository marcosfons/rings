import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/services.dart';

class Field {
	final String _name;
	final String _fieldName;
	final TextInputFormatter? _textInputFormatter;
	final bool _isNumeric;
	String _value;
	final bool _nullable;

  Field(this._name, this._fieldName, {String? mask, bool isNumeric=false, String value='', bool nullable=false})
		: _value = value,
			_textInputFormatter = mask != null ? TextInputMask(mask: mask) : null,
			_isNumeric = isNumeric,
			_nullable = nullable;

	String get name => _name;
	String get fieldName => _fieldName;
	TextInputFormatter? get textInputFormatter => _textInputFormatter;
	bool get isNumeric => _isNumeric;
	bool get isNullable => _nullable;
	String get value => _value;

	set value(String text) => _value = text.trim();

}