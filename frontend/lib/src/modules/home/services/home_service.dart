import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:rings/src/core/failures/failure.dart';
import 'package:rings/src/core/failures/unknown_failure.dart';
import 'package:rings/src/core/services/hasura/hasura_client.dart';
import 'package:rings/src/modules/home/models/employee.dart';

class HomeService {

	final HasuraClient _client = HasuraClient();

	Snapshot? _snapshot;
	StreamSubscription? _subscription;

	Future<Either<Failure, List<Employee>>> getEmployees() async {
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

		return result.fold<Either<Failure, List<Employee>>>(
			(failure) => left(failure),
			(data) {
				try {
					return right((data['employee'] as List)
						.map((employeeJson) => Employee.fromJson(employeeJson))
						.toList()); 
				} catch(e) {
					return left(UnknownFailure());
				}
			}
		);
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