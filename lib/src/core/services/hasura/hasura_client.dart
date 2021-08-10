import 'package:hasura_connect/hasura_connect.dart';

class HasuraClient {

	final _hasuraConnect = HasuraConnect(
		'https://rings-tp.herokuapp.com/v1/graphql',
		headers: { 'x-hasura-admin-secret': 'VTwkuCbp66FnsjX2a3TynGH88EctGVRN' }
	);

	Future<Map<String, dynamic>> query(String doc, {Map<String, dynamic>? variables}) async {
		final result = await _hasuraConnect.query(doc, variables: variables);
		return result['data'] as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> mutation(String doc, {Map<String, dynamic>? variables}) async {
		final result = await _hasuraConnect.mutation(doc, variables: variables);
		return result['data'] as Map<String, dynamic>;
	}

	Future<Snapshot<dynamic>> subscribe(String doc, {Map<String, dynamic>? variables}) async {
		final result = await _hasuraConnect.subscription(doc, variables: variables);
		return result;
	}

}