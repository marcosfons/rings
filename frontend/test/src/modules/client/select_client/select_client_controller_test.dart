import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rings/src/core/models/client.dart';
import 'package:rings/src/core/services/hasura/failures/empty_result_failure.dart';
import 'package:rings/src/modules/client/select_client/select_client_controller.dart';
import 'package:rings/src/modules/client/select_client/services/select_client_service.dart';

class MockClient extends Mock implements Client {}

class MockSelectClientService extends Mock implements SelectClientService {}

void main() {
	late MockSelectClientService mockSelectClientService;
	late SelectClientController selectClientController;

	setUp(() {
		mockSelectClientService = MockSelectClientService();
		selectClientController = SelectClientController(mockSelectClientService);
	});

	test('Load clients without results, should return an empty result failure', () async {
		when(() => mockSelectClientService.getClients())
			.thenAnswer((_) => Future.value(left(EmptyResultFailure())));

		await selectClientController.loadClients();

		expect(selectClientController.filteredClients, null);
		expect(selectClientController.error, EmptyResultFailure().message);
	});

	test('Load one valid client without search', () async {
		final mockClient = MockClient();
		when(() => mockClient.name).thenReturn('Frodo Baggins');
		when(() => mockSelectClientService.getClients())
			.thenAnswer((_) => Future.value(right([ mockClient ])));

		await selectClientController.loadClients();

		expect(selectClientController.filteredClients, isNotNull);
		expect(selectClientController.filteredClients!.length, 1);
		expect(selectClientController.filteredClients![0], isA<Client>());
		expect(selectClientController.error, isNull);
	});

	test('Load one valid client with a search for the right name', () async {
		final mockClient = MockClient();
		when(() => mockClient.name).thenReturn('Frodo Baggins');
		when(() => mockSelectClientService.getClients())
			.thenAnswer((_) => Future.value(right([ mockClient ])));

		await selectClientController.loadClients();

		selectClientController.search('Frodo');

		expect(selectClientController.filteredClients, isNotNull);
		expect(selectClientController.filteredClients!.length, 1);
		expect(selectClientController.filteredClients![0], isA<Client>());
		expect(selectClientController.filteredClients![0].name, contains('Frodo'));
	});

	test('Load one valid client with a search for the wrong name, should return an empty list', () async {
		final mockClient = MockClient();
		when(() => mockClient.name).thenReturn('Frodo Baggins');
		when(() => mockClient.cpf).thenReturn('000.000.000-00');
		when(() => mockSelectClientService.getClients())
			.thenAnswer((_) => Future.value(right([ mockClient ])));

		await selectClientController.loadClients();

		selectClientController.search('Legolas');

		expect(selectClientController.filteredClients, isNotNull);
		expect(selectClientController.filteredClients!.isEmpty, true);
	});

	test('Load one valid client with a CPF search, should return the client', () async {
		final mockClient = MockClient();
		when(() => mockClient.name).thenReturn('Frodo Baggins');
		when(() => mockClient.cpf).thenReturn('000.000.000-00');
		when(() => mockSelectClientService.getClients())
			.thenAnswer((_) => Future.value(right([ mockClient ])));

		await selectClientController.loadClients();

		selectClientController.search('000.000');

		expect(selectClientController.filteredClients, isNotNull);
		expect(selectClientController.filteredClients!.length, 1);
		expect(selectClientController.filteredClients![0], isA<Client>());
		expect(selectClientController.filteredClients![0].cpf, contains('000.000'));
	});

}