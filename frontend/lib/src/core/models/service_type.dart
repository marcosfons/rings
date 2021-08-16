enum ServiceType { insurance, loan, autoPhoneRecharge }

extension ServiceTypeExtension on ServiceType {
  String get name {
    switch (this) {
      case ServiceType.insurance:
        return 'Seguro';
      case ServiceType.autoPhoneRecharge:
        return 'Recarga automática de celular';
      case ServiceType.loan:
        return 'Empréstimo';
    }
  }

	String get typeName {
    switch (this) {
      case ServiceType.insurance:
        return 'insurance';
      case ServiceType.autoPhoneRecharge:
        return 'auto_phone_recharge';
      case ServiceType.loan:
        return 'loan';
    }
  }
}

extension ServiceTypeGeneratorExtension on String {
	ServiceType get serviceFromName {
		switch (this) {
      case 'insurance':
        return ServiceType.insurance;
      case 'loan':
        return ServiceType.loan;
      case 'auto_phone_recharge':
        return ServiceType.autoPhoneRecharge;
			default:
				return ServiceType.autoPhoneRecharge;
    }
	}

}
