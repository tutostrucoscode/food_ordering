import 'package:food_ordering/src/domain/auth_service_contract.dart';
import 'package:async/async.dart';
import 'package:food_ordering/src/domain/token.dart';

class SignInUseCase {
  final IAuthService _authService;

  SignInUseCase(this._authService);

  Future<Result<Token>> execute() async {
    return await _authService.signIn();
  }
}
