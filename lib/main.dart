/// ----------------------------------------------
/// ARQUIVO: main.dart
/// RESPONSABILIDADE:
/// Ponto de entrada da aplicação Flutter.
/// Este arquivo executa a aplicação inicial utilizando o widget MyApp,
/// que encapsula a configuração principal do aplicativo, como tema,
/// rotas e estado inicial.
///
/// Toda a lógica principal de construção de telas e navegação
/// é delegada ao widget MyApp, definido no arquivo 'my_app.dart'.
/// ----------------------------------------------
library;

import 'package:flutter/material.dart'; // Importa o framework UI do Flutter.
import 'package:flutter_desbloqueio_biometria/my_app.dart'; // Importa o widget principal da aplicação.

/// Função main - ponto de entrada da aplicação.
/// Utiliza a função `runApp` para iniciar o app com o widget raiz `MyApp`.
void main() => runApp(const MyApp());
