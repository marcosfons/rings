import 'package:rings/src/core/failures/failure.dart';

class InvalidQueryFailure extends Failure {
  const InvalidQueryFailure() : super('Query inválida');
}