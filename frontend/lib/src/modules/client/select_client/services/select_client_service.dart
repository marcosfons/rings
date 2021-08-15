import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:rings/src/core/failures/failure.dart';
import 'package:rings/src/core/failures/unknown_failure.dart';
import 'package:rings/src/core/services/hasura/failures/empty_result_failure.dart';
import 'package:rings/src/core/services/hasura/hasura_client.dart';
import 'package:rings/src/modules/client/models/client.dart';

class SelectClientService {

	final _hasuraClient = Get.find<HasuraClient>();

	Future<Either<Failure, List<Client>>> getClients() async {
		try {
			final result = await _hasuraClient.query(_queryClients);

			return result.fold<Either<Failure, List<Client>>>(
				(failure) => left(failure), 
				(json) {
					final clients = (json['client'] as List)
						.map((clientJson) => Client.fromJson(clientJson))
						.toList();

					if (clients.length == 0) {
						return left(const EmptyResultFailure());
					}
					return right(clients);
				}
			);
		} catch(e) {
			return left(const UnknownFailure());
		}
	}

	static const String _queryClients = r'''
	query {
		client {
			id
			name
			nickname
			cpf
			cnpj
			email
			address
			occupation
			phone
			address_receipt_image
			profit_receipt_image
			updated_at
			created_at
		}
	}
	''';

}