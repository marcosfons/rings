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
}

class Service {
  late final String name;
  late final int tax;
  late final int value;
  late final ServiceType type;

  Service(this.name, this.tax, this.value, this.type);
}
