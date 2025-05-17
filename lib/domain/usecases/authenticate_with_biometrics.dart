/// --------------------------------------------------------------------------
/// ARQUIVO: authenticate_with_biometrics.dart
/// RESPONSABILIDADE:
/// Caso de uso (UseCase) responsável por encapsular a lógica de autenticação
/// biométrica dentro da camada de domínio (Domain).
///
/// Ele define uma única responsabilidade:
/// - Delegar a chamada de autenticação biométrica para o repositório apropriado.
///
/// Esta estrutura segue os princípios da Clean Architecture:
/// - A camada de domínio não conhece detalhes da implementação (Platform Channel)
/// - A interface do repositório (`BiometricAuthRepository`) é usada para inversão de dependência
///
/// O resultado da autenticação é retornado como um `BiometricResult`.
/// --------------------------------------------------------------------------
library;

import 'package:flutter_desbloqueio_biometria/domain/entities/biometric_auth_repository.dart';
import '../entities/biometric_result.dart';

/// Caso de uso responsável por realizar a autenticação biométrica
/// através de um repositório abstraído.
class AuthenticateWithBiometrics {
  /// Repositório que fornece acesso à autenticação biométrica.
  final BiometricAuthRepository repository;

  /// Construtor que recebe o repositório como dependência.
  /// Isso permite inversão de controle e facilita testes.
  AuthenticateWithBiometrics(this.repository);

  /// Executa a autenticação biométrica.
  /// Retorna um `BiometricResult` que indica o resultado (sucesso, falha, cancelamento, etc).
  Future<BiometricResult> call() {
    return repository.authenticate();
  }
}
