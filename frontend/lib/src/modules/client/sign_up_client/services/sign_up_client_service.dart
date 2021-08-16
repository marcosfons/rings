import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:rings/src/core/controllers/auth_controller.dart';
import 'package:rings/src/core/failures/failure.dart';
import 'package:rings/src/core/failures/unknown_failure.dart';
import 'package:rings/src/core/models/client.dart';
import 'package:rings/src/core/services/hasura/hasura_client.dart';
import 'package:rings/src/modules/client/sign_up_client/models/field.dart';

class SignUpClientService {

	final HasuraClient _hasuraClient = Get.find<HasuraClient>();

	Future<Either<Failure, Client>> createClient(List<Field> fields) async {
		try {
			final agencyId = Get.find<AuthController>().employee.agency.id;
			final clientFields = Map.fromIterable(
				fields,
				key: (field) => field.fieldName,
				value: (field) {
					if (field.isNullable && field.value.isEmpty) {
						return null;
					}
					return field.value;
				}
			);

			final random = Random();
			final numbers = List.generate(7, (_) => random.nextInt(10));
			final number = numbers.join('');

			final account = {
				'agency_id': agencyId,
				'number': number,
				'type': 'checking'
			};

			final result = await _hasuraClient.mutation(
				_insertUser,
				variables: {'client': clientFields..addAll({
					'address_receipt_image': '',
					'profit_receipt_image': '',
					'accounts': { 'data': account }
				}) }
			);

			return result.fold(
				(failure) => left(failure),
				(data) => right(Client.fromJson(data['insert_client_one']))
			);
		} catch(e) {
			print(e.toString());
			return left(UnknownFailure());
		}
	}

	static const String _insertUser = r'''
	mutation ($client: client_insert_input!) {
		insert_client_one(object: $client) {
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