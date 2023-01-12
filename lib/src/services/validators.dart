import 'package:get/get.dart';

class Validators {
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Digite seu e-mail!';
    }
    if (!email.isEmail) {
      return 'Digite um e-mail válido!';
    }
    return null;
  }

  static String? passwordValidator(String? senha) {
    if (senha == null || senha.isEmpty) {
      return 'Digite sua senha!';
    }
    if (senha.length < 7) {
      return 'Crie uma senha com pelo menos 7 digitos';
    }
    return null;
  }

  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Digite um nome completo!';
    }
    if (name.split(' ').length == 1) {
      return 'Digite também seu sobrenome!';
    }
    return null;
  }

  static String? phoneValidator(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Digite um celular!';
    }
    if (!phone.isPhoneNumber || phone.length < 15) {
      return 'Digite um número válido!';
    }
    return null;
  }

  static String? cpfValidator(String? cpf) {
    if (cpf == null || cpf.isEmpty) {
      return 'Digite um CPF!';
    }
    if (!cpf.isCpf) {
      return 'Digite um CPF válido!';
    }
    return null;
  }
}
