import 'package:rings/src/core/failures/failure.dart';

class EmptyResultFailure extends Failure {
  const EmptyResultFailure() : super('Nenhum resultado encontrado');
}