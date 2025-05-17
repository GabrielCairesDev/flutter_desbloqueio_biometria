// ------------------------------------------------------------------------------
// ARQUIVO: MainActivity.kt
// RESPONSABILIDADE:
// Classe principal Android responsável por lidar com chamadas nativas vindas
// do Flutter via Platform Channel ("biometric_channel").
//
// Implementa a autenticação biométrica usando a API AndroidX BiometricPrompt,
// e comunica os resultados de volta ao Flutter via `MethodChannel`.
//
// Esta estrutura permite:
// - Integração segura com APIs nativas
// - Separação entre lógica Flutter e Android
// - Reutilização e testabilidade da camada de autenticação
// ------------------------------------------------------------------------------

package com.example.flutter_desbloqueio_biometria

import android.os.Bundle
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {

    // Nome do canal usado para comunicação com o Flutter.
    private val CHANNEL = "biometric_channel"

    /// Registra o canal e trata chamadas vindas do Dart (Flutter).
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "authenticate") {
                    authenticate(result) // Chama o método nativo de autenticação
                } else {
                    result.notImplemented()
                }
            }
    }

    /// Executa a autenticação biométrica utilizando BiometricPrompt.
    /// Retorna o resultado ao Flutter como "sucesso", "falha" ou erro via exception.
    private fun authenticate(result: MethodChannel.Result) {
        val executor = ContextCompat.getMainExecutor(this)

        // Configura o prompt exibido para o usuário
        val promptInfo = BiometricPrompt.PromptInfo.Builder()
            .setTitle("Autenticação Biométrica")
            .setSubtitle("Use sua digital ou rosto")
            .setNegativeButtonText("Cancelar")
            .build()

        // Cria o BiometricPrompt com callbacks de resposta
        val biometricPrompt = BiometricPrompt(this, executor,
            object : BiometricPrompt.AuthenticationCallback() {

                // Autenticação bem-sucedida
                override fun onAuthenticationSucceeded(authResult: BiometricPrompt.AuthenticationResult) {
                    super.onAuthenticationSucceeded(authResult)
                    result.success("sucesso")
                }

                // Erro durante o processo (ex: hardware indisponível, cancelado, etc)
                override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                    super.onAuthenticationError(errorCode, errString)
                    result.error("AUTH_ERROR", errString.toString(), null)
                }

                // Tentativa de autenticação falhou (biometria inválida, dedo incorreto, etc)
                override fun onAuthenticationFailed() {
                    super.onAuthenticationFailed()
                    result.success("falha")
                }
            })

        // Inicia o prompt biométrico
        biometricPrompt.authenticate(promptInfo)
    }
}
