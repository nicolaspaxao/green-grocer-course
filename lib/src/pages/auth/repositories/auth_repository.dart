import 'package:quitanda_com_getx/src/constants/endpoints.dart';
import 'package:quitanda_com_getx/src/models/user_model.dart';
import 'package:quitanda_com_getx/src/pages/auth/repositories/auth_errors.dart'
    as auth_errors;
import 'package:quitanda_com_getx/src/pages/auth/result/auth_result.dart';
import 'package:quitanda_com_getx/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  AuthResult handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.sucess(user);
    } else {
      return AuthResult.error(auth_errors.authErrosString(result['error']));
    }
  }

  Future<AuthResult> validateToken({required String token}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.validateToken,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    return handleUserOrError(result);
  }

  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signIn,
      method: HttpMethods.post,
      body: {
        'email': email,
        'password': password,
      },
    );

    return handleUserOrError(result);
  }

  Future<AuthResult> signUp(UserModel userModel) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signUp,
      method: HttpMethods.post,
      body: userModel.toJson(),
    );

    return handleUserOrError(result);
  }
}
