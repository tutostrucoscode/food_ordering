import 'package:async/src/result/result.dart';
import 'package:food_ordering/src/domain/auth_service_contract.dart';
import 'package:food_ordering/src/domain/credential.dart';
import 'package:food_ordering/src/domain/token.dart';
import 'package:food_ordering/src/infra/api/auth_api_contract.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth implements IAuthService {
  final IAuthApi _authApi;
  GoogleSignIn _googleSignIn;
  late GoogleSignInAccount _currentUser;

  GoogleAuth(this._authApi, [GoogleSignIn? googleSignIn])
      : this._googleSignIn = googleSignIn ??
            GoogleSignIn(
              scopes: ['email', 'profile'],
            );

  @override
  Future<Result<Token>> signIn() async {
    await _handleGoogleSignIn();
    if (_currentUser == null) {
      return Result.error('Faild to signin with Google');
    }
    Credential credential = Credential(
        type: AuthType.google,
        name: _currentUser.displayName!,
        email: _currentUser.email,
        password: '');
    var result = await _authApi.signIn(credential);
    if (result.isError) {
      return result.asError!;
    }
    return Result.value(Token(result.asValue!.value));
  }

  @override
  Future<void> signOut() async {
    _googleSignIn.disconnect();
  }

  _handleGoogleSignIn() async {
    try {
      _currentUser = (await _googleSignIn.signIn())!;
    } catch (error) {
      return;
    }
  }
}
