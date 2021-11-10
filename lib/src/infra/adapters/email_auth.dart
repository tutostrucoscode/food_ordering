import 'package:async/src/result/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_ordering/src/domain/auth_service_contract.dart';
import 'package:food_ordering/src/domain/credential.dart';
import 'package:food_ordering/src/domain/signup_service_contract.dart';
import 'package:food_ordering/src/domain/token.dart';
import 'package:food_ordering/src/infra/api/auth_api_contract.dart';
import 'package:async/async.dart';

class EmailAuth implements IAuthService, ISignUpService {
  final IAuthApi _api;
  Credential _credential;
  EmailAuth(this._api, this._credential);

  void credential(
      {@required required String email, @required required String password}) {
    _credential = Credential(
        type: AuthType.email, email: email, password: password, name: '');
  }

  @override
  Future<Result<Token>> signIn() async {
    assert(_credential != null);
    var result = await _api.signIn(_credential);
    if (result.isError) return result.asError!;
    return Result.value(Token(result.asValue!.value));
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<Result<Token>> signUp(
      String name, String email, String password) async {
    Credential credential = Credential(
        type: AuthType.email, name: name, email: email, password: password);
    var result = await _api.signUp(credential);
    if (result.isError) return result.asError!;
    return Result.value(Token(result.asValue!.value));
  }
}
