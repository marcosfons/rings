import 'package:dartz/dartz.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:rings/src/core/failures/failure.dart';
import 'package:rings/src/core/failures/unknown_failure.dart';
import 'package:rings/src/core/services/hasura/failures/hasura_request_failure.dart';
import 'package:rings/src/core/services/hasura/failures/invalid_query.dart';
import 'package:rings/src/core/services/hasura/hasura_auth_interceptor.dart';

class HasuraClient {

	final _hasuraConnect = HasuraConnect(
		'http://localhost:8080/v1/graphql',
		interceptors: [ HasuraAuthInterceptor() ]
	);

	Future<Either<Failure, Map<String, dynamic>>> query(
		String doc, 
		{Map<String, dynamic>? variables}
	) async {
		try {
			final result = await _hasuraConnect.query(doc, variables: variables);
			return right(result['data']);
		} on InvalidRequestError catch(e) {
			print(e.toString());
			if (e.message == 'Invalid document') 
				return left(const InvalidQueryFailure());
			return left(const UnknownFailure());
		} on HasuraRequestError catch(e) {
			return left(HasuraRequestFailure(e.message));
		} catch(e) {
			return left(const UnknownFailure());
		}
	}

	Future<Either<Failure, Map<String, dynamic>>> mutation(
		String doc, 
		{Map<String, dynamic>? variables}
	) async {
		try {
			final result = await _hasuraConnect.mutation(doc, variables: variables);
			return right(result['data']);
		} catch(e) {
			return left(UnknownFailure());
		}
	}

	Future<Snapshot<dynamic>> subscribe(String doc, {Map<String, dynamic>? variables}) async {
		return _hasuraConnect.subscription(doc, variables: variables);
	}

}