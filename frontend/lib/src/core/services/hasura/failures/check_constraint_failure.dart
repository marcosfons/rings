import 'package:rings/src/core/failures/failure.dart';

class CheckConstraintFailure extends Failure {
  CheckConstraintFailure(String constraint) : super('Dado inválido: $constraint');
}