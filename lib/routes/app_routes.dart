/// -----------------------------------------------------------
/// ARQUIVO: app_routes.dart
/// RESPONSABILIDADE:
/// Centralizar e organizar as rotas nomeadas da aplicação.
/// Este arquivo define constantes para os nomes das rotas
/// e um mapa que associa cada rota a seu respectivo widget.
///
/// Isso facilita a manutenção, evitando hardcoded strings
/// espalhadas pelo código, e centraliza a configuração
/// de navegação.
/// -----------------------------------------------------------
library;

import 'package:flutter/material.dart'; // Importa as definições de WidgetBuilder.
import 'package:flutter_desbloqueio_biometria/view/home_biometrics_view.dart'; // Importa a tela com biometria.
import 'package:flutter_desbloqueio_biometria/view/home_view.dart'; // Importa a tela principal padrão.

/// Classe responsável por definir as rotas da aplicação.
class AppRoutes {
  /// Rota nomeada para a tela principal padrão (sem biometria).
  static const String home = '/home';

  /// Rota nomeada para a tela com funcionalidade de biometria.
  static const String homeBiometrics = '/home-biometrics';

  /// Mapa de rotas: associa o nome da rota ao widget correspondente.
  /// Usado pelo `MaterialApp` na configuração de navegação.
  static Map<String, WidgetBuilder> get routes => {
    home: (context) => HomeView(),
    homeBiometrics: (context) => HomeBiometricsView(),
  };
}
