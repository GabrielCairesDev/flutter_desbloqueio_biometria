/// --------------------------------------------------------------------------
/// ARQUIVO: home_biometrics_view_model.dart
/// RESPONSABILIDADE:
/// ViewModel responsável por gerenciar a lógica de autenticação biométrica
/// da tela inicial protegida por biometria.
///
/// Funções principais:
/// - Verificar se a biometria está habilitada nas preferências locais
/// - Redirecionar o usuário para a tela principal caso a biometria não esteja ativada
/// - Executar autenticação biométrica e desbloquear o acesso
///
/// Essa lógica está integrada com:
/// - Platform Channels (acesso à biometria nativa)
/// - Repositório local de preferências
/// - Caso de uso de autenticação biométrica
/// --------------------------------------------------------------------------
library;

import 'package:flutter/material.dart';
import 'package:flutter_desbloqueio_biometria/core/platform_channels/biometric_auth_channel.dart';
import 'package:flutter_desbloqueio_biometria/data/local/biometrics_prefrences_respository.dart';
import 'package:flutter_desbloqueio_biometria/data/repositories/biometric_auth_repository_impl.dart';
import 'package:flutter_desbloqueio_biometria/domain/entities/biometric_result.dart';
import 'package:flutter_desbloqueio_biometria/domain/usecases/authenticate_with_biometrics.dart';
import 'package:flutter_desbloqueio_biometria/routes/app_routes.dart';

/// ViewModel da tela de biometria protegida.
/// Utiliza [ChangeNotifier] para atualizar a UI conforme mudanças no estado.
class HomeBiometricsViewModel extends ChangeNotifier {
  /// Caso de uso para autenticação via biometria, implementado com Platform Channel.
  final _biometricAuthenticator = AuthenticateWithBiometrics(
    BiometricAuthRepositoryImpl(BiometricAuthChannel()),
  );

  /// Repositório que gerencia o estado persistido da biometria.
  final _biometricsPrefsRepository = BiometricsPreferencesRepository();

  /// Chave usada para armazenar/recuperar a configuração de biometria.
  final _biometricsKey = 'biometrics';

  /// Estado para controle de carregamento (ex: exibir spinner na UI).
  bool isLoading = true;

  /// Método inicial que verifica se a biometria está habilitada.
  /// Se não estiver, redireciona o usuário para a tela padrão (sem biometria).
  void init(BuildContext context) {
    _loadBiometrics(context);
  }

  /// Lê as preferências de biometria e redireciona se necessário.
  /// Caso a biometria não esteja ativada, a tela é substituída pela `HomeView`.
  Future<void> _loadBiometrics(BuildContext context) async {
    final biometrics = await _biometricsPrefsRepository.read(_biometricsKey);

    if (biometrics == null || biometrics == false) {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
        );
      }
    }

    isLoading = false;
    notifyListeners();
  }

  /// Executa o processo de autenticação biométrica.
  /// Se for bem-sucedido, desbloqueia o app redirecionando para a `HomeView`.
  Future<void> unlockBiometrics(BuildContext context) async {
    final result = await _biometricAuthenticator();

    if (result == BiometricResult.success && context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    }
  }
}
