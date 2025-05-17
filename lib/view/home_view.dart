/// --------------------------------------------------------------------------
/// ARQUIVO: home_view.dart
/// RESPONSABILIDADE:
/// Tela principal da aplicação (sem proteção por biometria).
/// Permite ao usuário:
/// - Ver o estado atual da biometria (ativada ou desativada)
/// - Ativar/desativar a autenticação biométrica com botão de ação
///
/// Essa tela está conectada ao `HomeViewModel`, que gerencia:
/// - Carregamento das preferências de biometria
/// - Execução da autenticação
/// - Atualização do estado com ChangeNotifier
///
/// A UI reage automaticamente às mudanças via `ListenableBuilder`.
/// --------------------------------------------------------------------------
library;

import 'package:flutter/material.dart';
import 'package:flutter_desbloqueio_biometria/view_model/home_view_model.dart';

/// Widget de estado para a HomeView, pois precisa reagir a mudanças do ViewModel.
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  /// Instância do ViewModel, responsável pela lógica de negócio.
  final viewModel = HomeViewModel();

  /// Método chamado ao iniciar o widget — inicializa dados no ViewModel.
  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  /// Constrói a interface da tela.
  /// Usa `ListenableBuilder` para reconstruir a interface sempre que o ViewModel notificar mudanças.
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return _view();
      },
    );
  }

  /// Constrói a estrutura principal da tela com colunas e espaçamentos.
  Widget _view() {
    return Scaffold(
      body: Column(
        children: [
          Spacer(), // Espaço flexível no topo
          _info(), // Informações visuais sobre o estado da biometria
          Spacer(), // Espaço entre info e botão
          _button(), // Botão para ativar/desativar a biometria
          SizedBox(height: 48), // Espaço inferior fixo
        ],
      ),
    );
  }

  /// Exibe um ícone e texto informando se a biometria está ativada ou não.
  Widget _info() {
    Color color = viewModel.biometricsEnabled ? Colors.green : Colors.red;
    String text = viewModel.biometricsEnabled ? 'ativada' : 'desativada';
    return Center(
      child: Column(
        children: [
          Icon(Icons.fingerprint, size: 100, color: color),
          Text('Biometria $text', style: TextStyle(fontSize: 24, color: color)),
        ],
      ),
    );
  }

  /// Botão que permite ativar ou desativar a biometria.
  /// A cor e o texto mudam dinamicamente com base no estado atual.
  Widget _button() {
    Color color = viewModel.biometricsEnabled ? Colors.red : Colors.green;
    String text = viewModel.biometricsEnabled ? 'Desativar' : 'Ativar';
    return ElevatedButton(
      onPressed: viewModel.toggleBiometrics, // Chama a função do ViewModel
      child: Text(
        '$text Biometria',
        style: TextStyle(fontSize: 32, color: color),
      ),
    );
  }
}
