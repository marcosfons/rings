import 'package:dartz/dartz.dart';
import 'package:rings/src/core/failures/failure.dart';
import 'package:rings/src/core/failures/unknown_failure.dart';
import 'package:rings/src/core/services/hasura/hasura_client.dart';
import 'package:rings/src/modules/auth/sign_in/models/sign_in_data.dart';

class SignInService {

	final HasuraClient _client;

  SignInService(this._client);

	Future<Either<Failure, SignInData>> signIn(String email, String password) async {
		try {
			final result = await _client.query(
				_signInQuery,
				variables: {
					'email': email,
					'password': password
				}
			);
			
			return result.fold(
				(failure) => left(failure),
				(data) {
					try {
						return right(SignInData.fromJson(data['signin']));
					} catch(e) {
						return left(const UnknownFailure());
					}
				}
			);
		} catch(e) {
			return left(const UnknownFailure());
		}
	}

	static const _signInQuery = r'''
	query signIn($email: String!, $password: String!){
		signin(email: $email, password: $password) {
			employee_id
			token
			employee {
				created_at
				email
				id
				image
				name
				password
				updated_at
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