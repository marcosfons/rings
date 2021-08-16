import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:rings/src/core/failures/failure.dart';
import 'package:rings/src/core/failures/unknown_failure.dart';
import 'package:rings/src/core/models/client.dart';
import 'package:rings/src/core/services/hasura/hasura_client.dart';

class HomeService {

	final _client = Get.find<HasuraClient>();

	Future<Either<Failure, List<Client>>> getClients() async {
		final result = await _client.query(_queryClients);

		return result.fold<Either<Failure, List<Client>>>(
			(failure) => left(failure),
			(data) {
				try {
					return right((data['client'] as List)
						.map((clientJson) => Client.fromJson(clientJson))
						.toList()); 
				} catch(e) {
					return left(UnknownFailure());
				}
			}
		);
	}

	static const String _queryClients = r'''
	query {
		client {
			address
			address_receipt_image
			cnpj
			cpf
			created_at
			email
			id
			name
			nickname
			occupation
			phone
			profit_receipt_image
			updated_at
		}
	}
	''';

}