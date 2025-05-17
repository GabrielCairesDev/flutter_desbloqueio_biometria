/// -----------------------------------------------------------
/// ARQUIVO: my_app.dart
/// RESPONSABILIDADE:
/// Widget raiz da aplicação Flutter.
/// Define a estrutura base do app, incluindo:
/// - Título da aplicação
/// - Página inicial (home)
/// - Rota inicial e mapeamento de rotas nomeadas
///
/// Este widget configura o MaterialApp, que controla
/// temas, navegação e transições entre telas.
/// -----------------------------------------------------------
library;

import 'package:flutter/material.dart'; // Importa os componentes de UI do Flutter.
import 'package:flutter_desbloqueio_biometria/routes/app_routes.dart'; // Importa as rotas nomeadas da aplicação.
import 'package:flutter_desbloqueio_biometria/view/home_biometrics_view.dart'; // Importa a tela inicial com suporte à biometria.

/// MyApp é um widget do tipo StatelessWidget que representa
/// o ponto de configuração principal da aplicação Flutter.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:
          'Flutter Demo', // Título exibido em contextos como listas de apps em Android
      home:
          HomeBiometricsView(), // Tela padrão caso a navegação por rotas não seja usada
      initialRoute:
          AppRoutes
              .homeBiometrics, // Define a rota inicial (preferida sobre `home`)
      routes:
          AppRoutes
              .routes, // Mapeia as rotas nomeadas para seus respectivos widgets
    );
  }
}
