# 🔐 Flutter Biometrics App

Este repositório demonstra como implementar **autenticação biométrica (impressão digital ou reconhecimento facial)** em um app Flutter, sem depender de pacotes externos.

## 📌 Sobre o projeto

A proposta é simples: permitir que o usuário **bloqueie e desbloqueie o app com biometria**, de forma segura e nativa, com uma arquitetura limpa e organizada.

### ✅ Tecnologias e conceitos utilizados:

- **Flutter + Kotlin (Platform Channel)**
- API nativa `BiometricPrompt` no Android
- Integração com `SharedPreferences` para salvar estado da biometria
- Arquitetura baseada em:
  - Camada de **domínio** com use cases e interfaces
  - Camada de **dados** com repositórios e preferências
  - Camada de **apresentação** com ViewModels

### 📂 Estrutura do projeto

O projeto está organizado em camadas, separando responsabilidades para facilitar manutenção, testes e escalabilidade.  
A autenticação é executada no Android via **Kotlin**, com comunicação direta por `MethodChannel`.

---

## 📷 Imagem de prévia

<!-- Adicione aqui o link da imagem de destaque (ex: link do GitHub ou CDN) -->
![preview](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*0KLZMiG2_2-s8NGu-00SxA.png)

---

