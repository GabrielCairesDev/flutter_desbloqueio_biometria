/// --------------------------------------------------------------------------
/// ARQUIVO: biometric_result.dart
/// RESPONSABILIDADE:
/// Enum que representa os possíveis resultados de uma tentativa de
/// autenticação biométrica.
///
/// Esse tipo é usado pelo caso de uso `AuthenticateWithBiometrics`
/// e por qualquer outra lógica que lide com o retorno da autenticação.
///
/// O uso de um `enum` torna o código mais legível, seguro e fácil de manter,
/// ao invés de depender de strings ou valores arbitrários.
/// --------------------------------------------------------------------------
library;

/// Enum que representa os estados possíveis após tentar autenticar via biometria.
enum BiometricResult {
  /// Autenticação realizada com sucesso.
  success,

  /// Autenticação falhou (ex: biometria incorreta, usuário não reconhecido).
  failure,

  /// Erro inesperado durante o processo (ex: sistema biométrico indisponível, exceções).
  error,
}
