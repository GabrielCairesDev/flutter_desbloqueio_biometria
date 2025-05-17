/// ----------------------------------------------------------------------
/// ARQUIVO: home_view_model.dart
/// RESPONSABILIDADE:
/// ViewModel responsável por encapsular a lógica de controle da interface
/// de biometria, incluindo:
/// - Verificar se a biometria está ativada
/// - Habilitar/desabilitar biometria com autenticação
/// - Persistir preferências localmente
///
/// Interage com os seguintes componentes:
/// - Platform Channel para autenticação nativa com biometria
/// - Repositório local de preferências (SharedPreferences)
/// - Caso de uso de autenticação com biometria
///
/// Notifica a UI sobre mudanças de estado via ChangeNotifier (MVVM).
/// ----------------------------------------------------------------------
library;

import 'package:flutter/material.dart';
import 'package:flutter_desbloqueio_biometria/core/platform_channels/biometric_auth_channel.dart';
import 'package:flutter_desbloqueio_biometria/data/local/biometrics_prefrences_respository.dart';
import 'package:flutter_desbloqueio_biometria/data/repositories/biometric_auth_repository_impl.dart';
import 'package:flutter_desbloqueio_biometria/domain/usecases/authenticate_with_biometrics.dart';
import 'package:flutter_desbloqueio_biometria/domain/entities/biometric_result.dart';

/// ViewModel que gerencia o estado da tela principal relacionada à biometria.
/// Extende [ChangeNotifier] para notificar a interface gráfica quando o estado mudar.
class HomeViewModel extends ChangeNotifier {
  /// Indica se a biometria está habilitada (valor persistido localmente).
  bool biometricsEnabled = false;

  /// Flag de carregamento (pode ser usada para mostrar loading na UI, mas não está em uso atualmente).
  bool isLoading = true;

  /// Caso de uso de autenticação biométrica, que executa a lógica de negócio.
  final _biometricAuthenticator = AuthenticateWithBiometrics(
    BiometricAuthRepositoryImpl(BiometricAuthChannel()),
  );

  /// Repositório local de preferências para armazenar configuração da biometria.
  final _biometricsPrefsRepository = BiometricsPreferencesRepository();

  /// Chave usada para armazenar a configuração no SharedPreferences.
  final _biometricsPrefsKey = 'biometrics';

  /// Inicializa o ViewModel carregando a configuração persistida da biometria.
  void init() {
    _loadBiometrics();
  }

  /// Lê a preferência local sobre uso de biometria.
  /// Atualiza o estado e notifica listeners (UI).
  Future<void> _loadBiometrics() async {
    final biometrics = await _biometricsPrefsRepository.read(
      _biometricsPrefsKey,
    );
    biometricsEnabled = biometrics ?? false;
    notifyListeners();
  }

  /// Alterna o uso de biometria: executa autenticação antes de permitir a mudança.
  /// Em caso de sucesso, salva a nova configuração e atualiza a UI.
  Future<void> toggleBiometrics() async {
    final result = await _biometricAuthenticator();

    if (result == BiometricResult.success) {
      biometricsEnabled = !biometricsEnabled;
      await _updateBiometrics();
      notifyListeners();
    }
  }

  /// Atualiza a configuração da biometria no armazenamento local.
  Future<void> _updateBiometrics() async {
    await _biometricsPrefsRepository.update(
      _biometricsPrefsKey,
      biometricsEnabled,
    );
  }
}
