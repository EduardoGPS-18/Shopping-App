class AuthException implements Exception {

  static const Map<String, String> errors = {
    "EMAIL_EXISTS": "Email não existe!",
    "OPERATION_NOT_ALLOWED": "Operação não permitida!",
    "TOO_MANY_ATTEMPTS_TRY_LATER": "Tende mais tarder!",
    "EMAIL_NOT_FOUND": "Email não encontrado!",
    "INVALID_PASSWORD":"Senha Invalida!",
    "USER_DISABLED":"Usuário desabilitado!",
  };

  final String key;

  const AuthException(this.key);

  @override
  String toString() {
    if(errors.containsKey(key)) {
      return errors[key];
    } else {
      return "Ocorreu um erro na autenticação!";
    }
  }  
}