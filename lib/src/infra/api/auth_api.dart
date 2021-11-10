import 'dart:convert';

import 'package:food_ordering/src/domain/credential.dart';
import 'package:async/src/result/result.dart';
import 'package:food_ordering/src/infra/api/mapper.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:food_ordering/src/infra/api/auth_api_contract.dart';

class AuthApi implements IAuthApi {
  final http.Client _client;
  String baseUrl;

  AuthApi(this.baseUrl, this._client);

  @override
  Future<Result<String>> signIn(Credential credential) async {
    Uri endpoint = (baseUrl + '/auth/signin') as Uri;
    return await _postCredential(endpoint, credential);
  }

  @override
  Future<Result<String>> signUp(Credential credential) async {
    Uri endpoint = (baseUrl + '/auth/signup') as Uri;
    return await _postCredential(endpoint, credential);
  }

  Future<Result<String>> _postCredential(
      Uri endpoint, Credential credential) async {
    var response =
        await _client.post(endpoint, body: Mapper.toJson(credential));

    if (response.statusCode != 200) return Result.error('Server error');
    var json = jsonDecode(response.body);

    return json['auth_token'] != null
        ? Result.value(json['auth_token'])
        : Result.error(json['message']);
  }
}
