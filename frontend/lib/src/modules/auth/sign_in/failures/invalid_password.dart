import 'package:rings/src/core/failures/failure.dart';

class InvalidPasswordFailure extends Failure {
  const InvalidPasswordFailure() : super('Senha inválida');
}