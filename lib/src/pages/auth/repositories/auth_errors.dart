String authErrosString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'E-mail e/ou senha inválidos.';
    case 'Invalid session token':
      return 'Token de usuário inválido.';
    case 'INVALID_FULLNAME':
      return 'Ocorreu um erro ao cadastrar usuário: Nome inválido.';
    case 'INVALID_PHONE':
      return 'Ocorreu um erro ao cadastrar usuário: Celular inválido.';
    case 'INVALID_CPF':
      return 'Ocorreu um erro ao cadastrar usuário: CPF inválido.';
    default:
      return 'Um erro indefinido ocorreu.';
  }
}
