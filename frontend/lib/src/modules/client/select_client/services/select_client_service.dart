import 'package:dartz/dartz.dart';
import 'package:rings/src/core/failures/failure.dart';
import 'package:rings/src/core/failures/unknown_failure.dart';
import 'package:rings/src/core/models/client.dart';
import 'package:rings/src/core/services/hasura/failures/empty_result_failure.dart';
import 'package:rings/src/core/services/hasura/hasura_client.dart';

class SelectClientService {

	final HasuraClient _hasuraClient;

  SelectClientService(this._hasuraClient);

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
			address
			address_receipt_image
			cpf
			cnpj
			created_at
			email
			id
			name
			nickname
			occupation
			phone
			profit_receipt_image
			updated_at
			accounts {
				services(where: {canceled_at: {_is_null: true}}) {
					account_id
					canceled_at
					created_at
					due_at
					hired_at
					id
					insurance
					name
					tax
					type
					value
				}
				updated_at
				type
				number
				id
				created_at
				client_id
				balance
				agency_id
				agency {
					city
					created_at
					id
					name
					number
					state
				}
			}
		}
	}
	''';

}