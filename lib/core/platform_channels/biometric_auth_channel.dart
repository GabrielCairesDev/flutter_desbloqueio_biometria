/// ------------------------------------------------------------------------------
/// ARQUIVO: biometric_auth_channel.dart
/// RESPONSABILIDADE:
/// Classe responsável por realizar a ponte entre o código Flutter e o código
/// nativo da plataforma (Android/iOS) através de `MethodChannel`.
///
/// Essa classe encapsula o canal "biometric_channel", usado para invocar o método
/// nativo `authenticate`, que realiza a autenticação biométrica diretamente
/// nas APIs nativas.
///
/// Retorna uma `String` com o resultado, que será posteriormente interpretada
/// pela implementação do repositório (ex: sucesso, falha ou erro).
///
/// Vantagens dessa abordagem:
/// - Mantém o código Flutter desacoplado da implementação nativa
/// - Facilita a manutenção e testes das camadas superiores
/// - Centraliza a lógica de comunicação com a plataforma
/// ------------------------------------------------------------------------------
library;

import 'package:flutter/services.dart';

/// Classe que encapsula o canal de comunicação com código nativo
/// para autenticação biométrica via Platform Channels.
class BiometricAuthChannel {
  /// Canal nomeado utilizado para enviar chamadas de método ao código nativo.
  static const MethodChannel _channel = MethodChannel('biometric_channel');

  /// Realiza a chamada ao método nativo `authenticate`.
  /// Invoca o método nativo `authenticate` e espera uma `String` como resultado.
  /// Retorna "sucesso", "falha" ou "erro", dependendo da resposta do código nativo.
  /// Caso a resposta seja nula, assume "falha" como padrão.

  Future<String> authenticate() async {
    try {
      final result = await _channel.invokeMethod<String>('authenticate');
      return result ?? 'falha'; // Caso a resposta seja nula, assume falha
    } catch (e) {
      return 'erro'; // Qualquer exceção é considerada erro genérico
    }
  }
}
