import 'package:get/get.dart';
import 'package:quitanda_com_getx/src/constants/storage_keys.dart';
import 'package:quitanda_com_getx/src/models/user_model.dart';
import 'package:quitanda_com_getx/src/pages/auth/repositories/auth_repository.dart';
import 'package:quitanda_com_getx/src/services/utils_services.dart';

import '../../../../app_pages.dart';
import '../result/auth_result.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final _authRepository = AuthRepository();

  UserModel user = UserModel();

  Future<void> validateToken() async {
    String? token = await UtilServices.getLocalData(key: StorageKeys.token);
    if (token == null) {
      Get.offAllNamed(PagesRoutes.signinRoute);
      return;
    }
    final result = await _authRepository.validateToken(token: token);
    result.when(
      sucess: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        signOut();
      },
    );
  }

  Future<void> signOut() async {
    user = UserModel();
    await UtilServices.removeLocalData(key: StorageKeys.token);
    Get.offAllNamed(PagesRoutes.signinRoute);
  }

  saveTokenAndProceedToBase() {
    UtilServices.saveLocalData(key: StorageKeys.token, data: user.token!);
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    AuthResult result =
        await _authRepository.signIn(email: email, password: password);
    isLoading.value = false;
    result.when(
      sucess: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        UtilServices.showToast(
          title: message,
          isError: true,
        );
      },
    );
  }

  Future<void> signUp() async {
    isLoading.value = true;
    AuthResult result = await _authRepository.signUp(user);
    isLoading.value = false;
    result.when(
      sucess: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        UtilServices.showToast(
          title: message,
          isError: true,
        );
      },
    );
  }
}
