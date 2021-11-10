import 'package:async/async.dart';
import 'package:food_ordering/src/domain/signup_service_contract.dart';
import 'package:food_ordering/src/domain/token.dart';

class SignUpUseCase {
  final ISignUpService _signUpService;

  SignUpUseCase(this._signUpService);

  Future<Result<Token>> execute(
      String name, String email, String password) async {
    return await _signUpService.signUp(name, email, password);
  }
}
