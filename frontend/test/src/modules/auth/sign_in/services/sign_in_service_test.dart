import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rings/src/core/failures/failure.dart';
import 'package:rings/src/core/failures/unknown_failure.dart';
import 'package:rings/src/core/services/hasura/hasura_client.dart';
import 'package:rings/src/modules/auth/sign_in/models/sign_in_data.dart';
import 'package:rings/src/modules/auth/sign_in/services/sign_in_service.dart';

class MockHasuraClient extends Mock implements HasuraClient {}
void main() {
	late MockHasuraClient mockHasuraClient;
	late SignInService signInService;

	setUp(() {
		mockHasuraClient = MockHasuraClient();
		signInService = SignInService(mockHasuraClient);
	}); 

	test('Request returned a failure, should return a failure', () async {
		when(() => mockHasuraClient.query(any(), variables: any(named: 'variables')))
			.thenAnswer((_) => Future.value(left(const UnknownFailure())));

		final result = await signInService.signIn('', '');

		expect(result, Left(const UnknownFailure()));
	});

	test('Request returned an error, should return a failure', () async {
		when(() => mockHasuraClient.query(any(), variables: any(named:'variables')))
			.thenThrow(Exception(''));

		final result = await signInService.signIn('', '');

		expect(result, Left(const UnknownFailure()));
	});

	test('Returned an invalid response, missing dates and image', () async {
		when(() => mockHasuraClient.query(any(), variables: any(named:'variables')))
			.thenAnswer((_) => Future.value(right({
				"signin": { "token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbXBsb3llZUlkIjoxLCJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLXVzZXItaWQiOiIxIiwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiZW1wbG95ZWUiLCJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVzIjpbImVtcGxveWVlIl19LCJpYXQiOjE2MjkyMDg3NjYsImV4cCI6MTYyOTIxMjM2NiwiaXNzIjoicmluZ3MifQ.RcmOvnS8-uL1gx9RG3ReIfhiTWyQvP8HwD0V3C4e-ecSBlJebu9IPtJdO-FcLmUfMLrxtVkSeoJhmlJkLiq7lA", "employee_id": 1, "employee": { "id": 1, "name": "Gandalf", "agency_id": 1, "email": "gandalf@gmail.com" } }
			})));

		final result = await signInService.signIn('', '');

		expect(result.isLeft(), true);
		expect(result, Left(const UnknownFailure()));
	});

	test('Returned valid response', () async {
		when(() => mockHasuraClient.query(any(), variables: any(named:'variables')))
			.thenAnswer((_) => Future.value(right({
				"signin": { "token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbXBsb3llZUlkIjoxLCJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLXVzZXItaWQiOiIxIiwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiZW1wbG95ZWUiLCJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVzIjpbImVtcGxveWVlIl19LCJpYXQiOjE2MjkyMDkxMjYsImV4cCI6MTYyOTIxMjcyNiwiaXNzIjoicmluZ3MifQ.cms9pRqW0v5CfCxV6vMGommtQJyMwjUNIx68riUYcSn6hHT38rqSsydsrf_gxZhL2LGk_mtHO9ZBOYN7UhcRSw", "employee_id": 1, "employee": { "id": 1, "name": "Gandalf", "agency_id": 1, "email": "gandalf@gmail.com", "created_at": "2021-08-16T18:10:48.080985+00:00", "image": "imagem", "updated_at": "2021-08-16T18:10:48.080985+00:00", "agency": { "city": "Piúma", "created_at": "2021-08-16T14:30:15.902743+00:00", "id": 1, "name": "Name", "number": "0087", "state": "ES" } } }
			})));

		final result = await signInService.signIn('', '');

		expect(result.isRight(), true);
		expect(result, isA<Right<Failure, SignInData>>());
	});

}