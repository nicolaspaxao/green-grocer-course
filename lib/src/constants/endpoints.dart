const String baseUrl = 'https://parseapi.back4app.com/functions';

abstract class Endpoints {
  static const String signIn = '$baseUrl/login';
  static const String signUp = '$baseUrl/signup';
  static const String validateToken = '$baseUrl/validate-token';
  static const String resetPassword = '$baseUrl/reset-password';
  static const String getAllCategories = '$baseUrl/get-category-list';
}
