/// --------------------------------------------------------------------------
/// ARQUIVO: home_biometrics_view.dart
/// RESPONSABILIDADE:
/// Tela inicial protegida por autenticação biométrica.
/// Esta tela:
/// - Exibe um ícone de biometria
/// - Apresenta um botão para desbloquear usando biometria
/// - Aguarda a verificação de estado com um indicador de loading
///
/// Toda a lógica está no `HomeBiometricsViewModel`, que:
/// - Verifica se a biometria está habilitada
/// - Redireciona para a tela principal se estiver desativada
/// - Realiza autenticação biométrica
///
/// A interface é reativa, utilizando `ListenableBuilder` para
/// responder a mudanças de estado (como `isLoading`).
/// --------------------------------------------------------------------------
library;

import 'package:flutter/material.dart';
import 'package:flutter_desbloqueio_biometria/view_model/home_biometrics_view_model.dart';

/// Tela inicial protegida por biometria.
/// Usa StatefulWidget pois depende do ciclo de vida para chamar o init.
class HomeBiometricsView extends StatefulWidget {
  const HomeBiometricsView({super.key});

  @override
  State<HomeBiometricsView> createState() => _HomeBiometricsViewState();
}

class _HomeBiometricsViewState extends State<HomeBiometricsView> {
  /// ViewModel responsável por verificar estado e autenticar biometria.
  final viewModel = HomeBiometricsViewModel();

  /// Método chamado na criação do widget.
  /// Inicializa o ViewModel e verifica o estado da biometria.
  @override
  void initState() {
    super.initState();
    viewModel.init(context);
  }

  /// Constrói a interface com escuta das mudanças via ChangeNotifier.
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return _view();
      },
    );
  }

  /// Exibe o conteúdo da tela dependendo do estado de carregamento.
  Widget _view() {
    return Scaffold(body: viewModel.isLoading ? _loading() : _content());
  }

  /// Exibe um indicador de carregamento enquanto o ViewModel está verificando o estado.
  Widget _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  /// Exibe o conteúdo principal da tela com ícone e botão de desbloqueio.
  Widget _content() {
    return Column(
      children: [
        const Spacer(),
        _icon(),
        const Spacer(),
        _button(),
        const SizedBox(height: 48),
      ],
    );
  }

  /// Ícone visual de biometria.
  Widget _icon() {
    return const Center(
      child: Icon(Icons.fingerprint, size: 100, color: Colors.orange),
    );
  }

  /// Botão que aciona o processo de autenticação biométrica.
  Widget _button() {
    return ElevatedButton(
      onPressed: () => viewModel.unlockBiometrics(context),
      child: const Text(
        'Desbloquear',
        style: TextStyle(fontSize: 32, color: Colors.orange),
      ),
    );
  }
}
