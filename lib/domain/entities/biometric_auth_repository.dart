/// --------------------------------------------------------------------------
/// ARQUIVO: biometric_auth_repository.dart
/// RESPONSABILIDADE:
/// Interface abstrata (contrato) para autenticação biométrica,
/// localizada na camada de domínio da aplicação.
///
/// Esta interface define o método necessário para realizar
/// a autenticação via biometria, sem expor como ela será feita.
///
/// A implementação concreta pode utilizar:
/// - Platform Channels (para integrar com APIs nativas Android/iOS)
/// - Plugins de terceiros
/// - Simulações ou mocks em testes
///
/// Permite:
/// - Inversão de dependência (SOLID)
/// - Testes unitários desacoplados de detalhes de plataforma
/// - Flexibilidade para trocar o mecanismo de autenticação
/// --------------------------------------------------------------------------
library;

import '../entities/biometric_result.dart';

/// Contrato para repositórios que realizam autenticação biométrica.
abstract class BiometricAuthRepository {
  /// Executa o processo de autenticação biométrica.
  /// Retorna um [BiometricResult] indicando o sucesso, falha ou erro.
  Future<BiometricResult> authenticate();
}
