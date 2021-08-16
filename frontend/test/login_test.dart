import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rings/src/core/failures/failure.dart';
import 'package:rings/src/modules/auth/sign_in/failures/invalid_email.dart';
import 'package:rings/src/modules/auth/sign_in/failures/invalid_password.dart';
import 'package:rings/src/modules/auth/sign_in/models/sign_in_data.dart';
import 'package:rings/src/modules/auth/sign_in/services/sign_in_service.dart';
import 'package:rings/src/modules/auth/sign_in/sign_in_controller.dart';

class MockSignInService extends Mock implements SignInService {}
void main() {
	late MockSignInService mockSignInService;
	late SignInController signInController;

	setUp(() {
		mockSignInService = MockSignInService();
		signInController = SignInController(mockSignInService);
	});

	test('SignIn with an empty email and password', () async {
		final result = await signInController.signIn();
		expect(result, Left<Failure, SignInData>(const InvalidEmailFailure()));
	});

	test('SignIn with an invalid email', () async {
		signInController.email = 'teste';
		signInController.password = 'teste';

		final result = await signInController.signIn();
		expect(result, Left<Failure, SignInData>(const InvalidEmailFailure()));
	});

	test('SignIn with an empty password', () async {
		signInController.email = 'teste@teste.com';

		final result = await signInController.signIn();
		expect(result, Left<Failure, SignInData>(const InvalidPasswordFailure()));
	});

	test('SignIn with a small invalid password', () async {
		signInController.email = 'teste@teste.com';
		signInController.password = '123';

		final result = await signInController.signIn();
		expect(result, Left<Failure, SignInData>(const InvalidPasswordFailure()));
	});

	test('SignIn with a small invalid password', () async {
		signInController.email = 'teste@teste.com';
		signInController.password = '1234';

		final result = await signInController.signIn();
		expect(result.isRight(), true);
	});

}