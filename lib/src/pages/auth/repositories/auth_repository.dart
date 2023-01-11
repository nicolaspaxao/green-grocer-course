import 'package:flutter/foundation.dart';
import 'package:quitanda_com_getx/src/constants/endpoints.dart';
import 'package:quitanda_com_getx/src/models/user_model.dart';
import 'package:quitanda_com_getx/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future signIn({
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

    if (result['result'] != null) {
      debugPrint('Signin true');
      final user = UserModel.fromMap(result as Map<String, dynamic>);
      debugPrint(user.toString());
    } else {
      debugPrint('Signin false');
      debugPrint(result['error']);
    }
  }
}
