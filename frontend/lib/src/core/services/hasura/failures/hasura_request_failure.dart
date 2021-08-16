import 'package:rings/src/core/failures/failure.dart';

class HasuraRequestFailure extends Failure {
  HasuraRequestFailure(String errorMessage) : super('Erro ao fazer o request ($errorMessage)');
}