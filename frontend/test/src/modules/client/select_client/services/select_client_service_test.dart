import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rings/src/core/failures/unknown_failure.dart';
import 'package:rings/src/core/models/client.dart';
import 'package:rings/src/core/services/hasura/failures/empty_result_failure.dart';
import 'package:rings/src/core/services/hasura/hasura_client.dart';
import 'package:rings/src/modules/client/select_client/services/select_client_service.dart';

class MockHasuraClient extends Mock implements HasuraClient {}

void main() {

	late MockHasuraClient mockHasuraClient;
	late SelectClientService selectClientService;

	setUp(() {
		mockHasuraClient = MockHasuraClient();
		selectClientService = SelectClientService(mockHasuraClient);
	});

	test('Get clients without results, should return an empty result failure', () async {
		when(() => mockHasuraClient.query(any()))
			.thenAnswer((_) => Future.value(right({'client': []})));

		final result = await selectClientService.getClients();

		expect(result.isLeft(), true); // Is a failure
		expect(result, Left(const EmptyResultFailure()));
	});

	test('Get clients with an unknown error, should return a failure', () async {
		when(() => mockHasuraClient.query(any()))
			.thenThrow(Exception(''));

		final result = await selectClientService.getClients();

		expect(result, Left(const UnknownFailure()));
	});

	test('Get clients with an unknown failure, should return a failure', () async {
		when(() => mockHasuraClient.query(any()))
			.thenAnswer((_) => Future.value(left(const UnknownFailure())));

		final result = await selectClientService.getClients();

		expect(result, Left(const UnknownFailure()));
	});

	test('Get clients with a one invalid client (CPF null), should return a failure', () async {
		when(() => mockHasuraClient.query(any()))
			.thenAnswer((_) {
				return Future.value(right({
					'client': [ { "address": "Bairro Condado", "address_receipt_image": "", "cpf": null, "cnpj": null, "created_at": "2021-08-16T18:15:31.80839+00:00", "email": "frodo@gmail.com", "id": 1, "name": "Frodo Baggins", "nickname": "Frodo", "occupation": "Cabelereiro", "phone": "+55 (32) 94002-8922", "profit_receipt_image": "", "updated_at": "2021-08-16T18:15:31.80839+00:00", "accounts": [ { "services": [ { "account_id": 1, "canceled_at": null, "created_at": "2021-08-16T18:42:25.699056+00:00", "due_at": null, "hired_at": "2021-08-16T18:42:25.699056+00:00", "id": 3, "insurance": null, "name": "Recarga automática de celular", "tax": 10, "type": "auto_phone_recharge", "value": null } ], "updated_at": "2021-08-16T18:15:31.80839+00:00", "type": "checking", "number": "2886003", "id": 1, "created_at": "2021-08-16T18:15:31.80839+00:00", "client_id": 1, "balance": 0, "agency_id": 1, "agency": { "city": "Piúma", "created_at": "2021-08-16T14:30:15.902743+00:00", "id": 1, "name": "Name", "number": "0087", "state": "ES" } } ] } ]
				}));
			});

		final result = await selectClientService.getClients();

		expect(result.isLeft(), true);
		expect(result, Left(const UnknownFailure()));
	});

	test('Get clients with a one valid client', () async {
		when(() => mockHasuraClient.query(any()))
			.thenAnswer((_) {
				return Future.value(right({
					'client': [ { "address": "Bairro Condado", "address_receipt_image": "", "cpf": "999.999.999-99", "cnpj": null, "created_at": "2021-08-16T18:15:31.80839+00:00", "email": "frodo@gmail.com", "id": 1, "name": "Frodo Baggins", "nickname": "Frodo", "occupation": "Cabelereiro", "phone": "+55 (32) 94002-8922", "profit_receipt_image": "", "updated_at": "2021-08-16T18:15:31.80839+00:00", "accounts": [ { "services": [ { "account_id": 1, "canceled_at": null, "created_at": "2021-08-16T18:42:25.699056+00:00", "due_at": null, "hired_at": "2021-08-16T18:42:25.699056+00:00", "id": 3, "insurance": null, "name": "Recarga automática de celular", "tax": 10, "type": "auto_phone_recharge", "value": null } ], "updated_at": "2021-08-16T18:15:31.80839+00:00", "type": "checking", "number": "2886003", "id": 1, "created_at": "2021-08-16T18:15:31.80839+00:00", "client_id": 1, "balance": 0, "agency_id": 1, "agency": { "city": "Piúma", "created_at": "2021-08-16T14:30:15.902743+00:00", "id": 1, "name": "Name", "number": "0087", "state": "ES" } } ] } ]
				}));
			});

		final result = await selectClientService.getClients();

		expect(result.isRight(), true);
		expect(result.getOrElse(() => []).length, 1); // One client received
		expect(result.getOrElse(() => [])[0], isA<Client>()); // One client received
	});

}