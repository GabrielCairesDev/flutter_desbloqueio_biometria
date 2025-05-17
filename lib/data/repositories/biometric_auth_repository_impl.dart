/// --------------------------------------------------------------------------
/// ARQUIVO: biometric_auth_repository_impl.dart
/// RESPONSABILIDADE:
/// Implementação concreta da interface [BiometricAuthRepository],
/// que realiza a autenticação biométrica utilizando Platform Channels.
///
/// Essa classe serve como um **adaptador** entre a camada de domínio e a
/// infraestrutura nativa, traduzindo resultados em tipos seguros do domínio.
///
/// Atua como ponte entre:
/// - A lógica de negócio (`AuthenticateWithBiometrics`)
/// - A camada de plataforma (`BiometricAuthChannel`)
///
/// Segue o princípio da inversão de dependência (D — SOLID),
/// permitindo isolar a lógica de autenticação para facilitar testes e manutenção.
/// --------------------------------------------------------------------------
library;

import 'package:flutter_desbloqueio_biometria/domain/entities/biometric_auth_repository.dart';
import '../../../domain/entities/biometric_result.dart';
import '../../../../core/platform_channels/biometric_auth_channel.dart';

/// Implementação de [BiometricAuthRepository] que utiliza Platform Channel
/// para realizar a autenticação biométrica com recursos nativos (ex: Android/iOS).
class BiometricAuthRepositoryImpl implements BiometricAuthRepository {
  /// Canal de comunicação com a camada nativa.
  final BiometricAuthChannel channel;

  /// Construtor que injeta o canal de autenticação.
  BiometricAuthRepositoryImpl(this.channel);

  /// Executa a autenticação nativa via Platform Channel e converte a string retornada
  /// (ex: "sucesso", "falha") em um [BiometricResult] seguro da camada de domínio.

  @override
  Future<BiometricResult> authenticate() async {
    final result = await channel.authenticate();

    switch (result) {
      case 'sucesso':
        return BiometricResult.success;
      case 'falha':
        return BiometricResult.failure;
      default:
        return BiometricResult.error;
    }
  }
}
