/// --------------------------------------------------------------------------
/// ARQUIVO: biometrics_repository.dart
/// RESPONSABILIDADE:
/// Interface abstrata (contrato) para operações de persistência de dados
/// relacionados à biometria (ativação/desativação) na camada de dados.
///
/// Essa interface define um contrato para qualquer implementação que
/// deseje salvar, ler, atualizar ou deletar configurações biométricas.
///
/// Exemplos de possíveis implementações:
/// - SharedPreferences (armazenamento local)
/// - Banco de dados local como Hive, SQLite
/// - Armazenamento seguro (secure storage)
///
/// Esta abstração promove:
/// - Independência da fonte de dados
/// - Facilidade de substituição e testes
/// - Aderência ao princípio da inversão de dependência (SOLID)
/// --------------------------------------------------------------------------
library;

abstract class BiometricsRepository {
  /// Cria (ou sobrescreve) uma entrada com a [key] e o valor booleano [value]
  /// Ex: ativar a biometria.
  Future<void> create(String key, bool value);

  /// Lê o valor booleano associado à [key], ou retorna null se não existir.
  /// Ex: verificar se a biometria está habilitada.
  Future<bool?> read(String key);

  /// Atualiza o valor associado à [key] com o novo [value].
  /// Deve assumir que a chave já existe.
  Future<void> update(String key, bool value);

  /// Remove a entrada associada à [key].
  /// Ex: desativar completamente a biometria e limpar o estado.
  Future<void> delete(String key);
}
