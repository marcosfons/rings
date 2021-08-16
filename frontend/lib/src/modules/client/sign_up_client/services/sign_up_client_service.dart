import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:rings/src/core/failures/failure.dart';
import 'package:rings/src/core/failures/unknown_failure.dart';
import 'package:rings/src/core/models/client.dart';
import 'package:rings/src/core/services/hasura/hasura_client.dart';
import 'package:rings/src/modules/client/sign_up_client/models/field.dart';

class SignUpClientService {

	final HasuraClient _hasuraClient = Get.find<HasuraClient>();

	Future<Either<Failure, Client>> createClient(List<Field> fields) async {
		try {
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
			
			final result = await _hasuraClient.mutation(
				_insertUser,
				variables: {'client': clientFields..addAll({
					'address_receipt_image': '',
					'profit_receipt_image': ''
				}) }
			);

			return result.fold(
				(failure) => left(failure),
				(data) => right(Client.fromJson(data['insert_client_one']))
			);
		} catch(e) {
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
		}
	}
	''';

}