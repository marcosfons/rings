import 'dart:async';

import 'package:hasura_connect/hasura_connect.dart';
import 'package:rings/src/core/services/hasura/hasura_client.dart';
import 'package:rings/src/modules/home/models/employee.dart';

class HomeService {

	final HasuraClient _client = HasuraClient();

	Snapshot? _snapshot;
	StreamSubscription? _subscription;

	Future<List<Employee>> getEmployees() async {
		final result = await _client.query(
			'''
			query {
				employee {
					id
					name
					image
				}
			}
			'''
		);
		return (result['employee'] as List)
				.map((employeeJson) => Employee.fromJson(employeeJson))
				.toList();
	}

	Future<Stream<List<Employee>>> getData() async {
		_snapshot = await _client.subscribe(
			'''
			subscription {
				employee {
					id
					name
					image
				}
			}
			''',
		);
		return _snapshot!.map((employees) {
			return (employees['data']['employee'] as List)
				.map((employeeJson) => Employee.fromJson(employeeJson))
				.toList();
		});
	}

	Future<void> dispose() async {
		await _subscription?.cancel();
		_snapshot?.close();
	}

}