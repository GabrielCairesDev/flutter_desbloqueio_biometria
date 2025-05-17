/// ------------------------------------------------------------------------------
/// ARQUIVO: biometrics_preferences_repository.dart
/// RESPONSABILIDADE:
/// Implementação concreta da interface [BiometricsRepository], responsável por
/// persistir o estado da biometria (ativada/desativada) usando o pacote
/// [SharedPreferences], que grava dados localmente no dispositivo.
///
/// Atua como parte da camada de infraestrutura da aplicação, permitindo que:
/// - A configuração da biometria seja armazenada entre sessões
/// - A lógica de domínio e apresentação permaneça desacoplada de detalhes técnicos
///
/// Este repositório é utilizado pelos ViewModels e segue princípios da
/// Clean Architecture, permitindo substituição e testes isolados.
/// ------------------------------------------------------------------------------
library;

import 'package:flutter_desbloqueio_biometria/domain/repositories/biometrics_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementação de [BiometricsRepository] usando SharedPreferences
/// para armazenamento local de pares chave-valor.
class BiometricsPreferencesRepository implements BiometricsRepository {
  /// Cria a chave no SharedPreferences com valor booleano, se ainda não existir.
  /// Evita sobrescrever configurações existentes.
  @override
  Future<void> create(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      await prefs.setBool(key, value);
    }
  }

  /// Lê o valor booleano associado à chave fornecida.
  /// Retorna null se a chave não estiver definida.
  @override
  Future<bool?> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  /// Atualiza o valor booleano de uma chave existente ou cria uma nova.
  @override
  Future<void> update(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  /// Remove completamente a chave armazenada.
  @override
  Future<void> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
