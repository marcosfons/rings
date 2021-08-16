import 'package:rings/src/core/failures/failure.dart';

class InvalidEmailFailure extends Failure {
  const InvalidEmailFailure() : super('Email inválido');
}