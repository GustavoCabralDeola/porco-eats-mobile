# Porco Eats

Aplicativo mobile de delivery desenvolvido com Flutter. O projeto reúne uma experiência de pedidos para clientes e uma área de acompanhamento de pedidos para gerentes, com catálogo de demonstração e dados armazenados localmente no dispositivo.

> **Status:** projeto em desenvolvimento, voltado a demonstração. O catálogo usa dados locais; autenticação, pagamentos e operações de pedidos não estão conectados a um backend ou serviço externo.

## Funcionalidades

- Cadastro e login locais, com opção de lembrar o usuário.
- Navegação pelo catálogo de produtos, categorias e ofertas.
- Carrinho com ajuste de quantidades e observações.
- Fluxo de finalização de pedido e consulta de pedidos do cliente.
- Área de gerenciamento para acompanhar pedidos e atualizar seus status.
- Perfil e telas de recuperação de acesso.
- Interface de seleção de forma de pagamento e endereço para demonstração.

## Tecnologias

- [Flutter](https://docs.flutter.dev/) e Dart.
- [Provider](https://pub.dev/packages/provider) para disponibilizar e consumir o estado da aplicação.
- `ChangeNotifier` como principal abordagem de gerenciamento de estado na maioria das funcionalidades.
- `shared_preferences` para persistência local de usuários e pedidos.
- `image_picker`, `video_player`, `google_fonts` e demais dependências listadas em [`pubspec.yaml`](pubspec.yaml).

## Requisitos

- Flutter SDK instalado e configurado no `PATH`.
- Dart SDK compatível com `^3.12.2` (conforme definido em `pubspec.yaml`).
- Git para clonar o repositório.
- Um dispositivo/emulador configurado para a plataforma desejada. Android Studio é recomendado para Android; o desenvolvimento e build para iOS exigem macOS e Xcode.

Confira a instalação do Flutter e os requisitos da sua plataforma na [documentação oficial](https://docs.flutter.dev/get-started/install).

## Como executar

Clone o repositório e entre na pasta do projeto:

```bash
git clone https://github.com/GustavoCabralDeola/porco-eats-mobile.git
cd porco-eats-mobile
```

Verifique se o ambiente está pronto:

```bash
flutter doctor
```

Baixe as dependências:

```bash
flutter pub get
```

Inicie um emulador ou conecte um dispositivo e execute:

```bash
flutter run
```

Para escolher um dispositivo, liste os disponíveis e informe o identificador:

```bash
flutter devices
flutter run -d <id-do-dispositivo>
```

Se estiver com o Chrome instalado e o suporte web habilitado, também é possível executar a versão web:

```bash
flutter run -d chrome
```

No VS Code, abra a pasta do projeto, selecione um dispositivo Flutter e pressione **F5**.

## Estrutura do projeto

```text
lib/
├── features/     # Telas e regras organizadas por funcionalidade
├── models/       # Modelos e enums da aplicação
├── shared/       # Serviços, dados de demonstração e widgets reutilizáveis
├── main.dart     # Inicialização e registro dos providers
└── routes.dart   # Rotas da aplicação
assets/
├── images/       # Imagens, ícones, categorias e produtos
└── videos/       # Vídeo usado no fluxo de login
```

As funcionalidades dentro de `lib/features/` incluem login/cadastro, início, carrinho, pedidos do cliente, gerenciamento de pedidos, pagamento e perfil. Na grande maioria delas, o estado é gerenciado por controllers que estendem `ChangeNotifier` e notificam a interface sobre atualizações. O `Provider` é usado para disponibilizar esses controllers e observar suas mudanças na árvore de widgets.

## Dados e limitações atuais

- Produtos e imagens fazem parte dos dados e assets locais do projeto.
- Contas e pedidos são armazenados localmente no dispositivo com `shared_preferences`; eles não são sincronizados entre aparelhos.
- O cadastro/login é demonstrativo e não substitui autenticação segura em servidor. Não use senhas reais ou dados pessoais sensíveis.
- A tela de pagamento não processa transações reais.
- Para disponibilizar o app em produção, será necessário integrar um backend, autenticação segura e um provedor de pagamentos.

## Verificações

Para analisar o código:

```bash
flutter analyze
```

Para executar os testes automatizados:

```bash
flutter test
```

## Licença

Nenhuma licença foi identificada neste repositório. Antes de reutilizar ou distribuir o projeto, confirme a licença com os responsáveis.
