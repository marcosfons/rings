import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:rings/src/core/failures/failure.dart';
import 'package:rings/src/core/failures/unknown_failure.dart';
import 'package:rings/src/core/models/client.dart';
import 'package:rings/src/core/models/service.dart';
import 'package:rings/src/core/services/hasura/hasura_client.dart';
import 'package:rings/src/modules/client/hire_service/services/failures/not_hired_service_failure.dart';

class HireServiceService {

	final _client = Get.find<HasuraClient>();

	Future<Either<Failure, bool>> hireService(Client client, ServiceType serviceType) async {
		try {
			final service = {
				'name': serviceType.name,
				'tax': 10,
				'account_id': client.accounts.first.id,
				'type': serviceType.typeName,
			};

			final result = await _client.mutation(
				_insertServiceMutation,
				variables: { 'service': service }
			);

			return result.fold(
				(failure) => left(failure),
				(data) => right(data['insert_service_one']['id'] != null)
			);
		} catch(e) {
			return left(const UnknownFailure());
		}
	}

	Future<Either<Failure, bool>> unhireService(Client client, ServiceType serviceType) async {
		try {
			Service? hiredService;
			for (final account in client.accounts) {
				for (final service in account.services) {
					if (service.serviceType == serviceType) {
						hiredService = service;
					}
				}
			}
			if (hiredService == null) {
				return left(NotHiredServiceFailure());
			}
			final result = await _client.mutation(
				_updateServiceMutation,
				variables: { 
					'service_id': hiredService.id,
					'canceled_at': DateTime.now().toIso8601String()
				}
			);

			return result.fold(
				(failure) => left(failure),
				(data) => right(data['update_service_by_pk']['canceled_at'] != null)
			);
		} catch(e) {
			return left(const UnknownFailure());
		}
	}



	static const String _insertServiceMutation = r'''
	mutation($service: service_insert_input!) {
		insert_service_one(object: $service) {
			id
		}
	}
	''';

	static const String _updateServiceMutation = r'''
	mutation($service_id: Int!, $canceled_at: timestamptz!) {
		update_service_by_pk(pk_columns: {id: $service_id}, _set: {canceled_at: $canceled_at}) {
			canceled_at
		}
	}
	''';

}