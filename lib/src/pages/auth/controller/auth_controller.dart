import 'package:get/get.dart';
import 'package:quitanda_com_getx/src/pages/auth/repositories/auth_repository.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final _authRepository = AuthRepository();

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    await _authRepository.signIn(email: email, password: password);
    isLoading.value = false;
  }
}
