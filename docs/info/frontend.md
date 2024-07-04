Claro! Aqui está o texto formatado em Markdown adequado para MkDocs em um único código contínuo:

```markdown
# Guia de Configuração do Front-end

## Como subir o front-end:

Antes de começar, verifique se o Flutter SDK está atualizado e compatível com o projeto. Siga as instruções específicas para sua plataforma (Windows, macOS, Linux) disponíveis na documentação oficial do Flutter.

Caso ainda não tenha feito, instale os seguintes requisitos em sua máquina:

#### Flutter SDK:
Siga as instruções de instalação para a sua plataforma.

#### Android Studio ou Visual Studio Code:

##### Android Studio:

```sh
sudo snap install android-studio --classic
```

##### Visual Studio Code:

```sh
sudo snap install code --classic
```

Para o VS Code, instale as extensões do Flutter e Dart disponíveis na aba de extensões do editor.

#### Emulador Android ou um dispositivo físico:
Configure um emulador usando o AVD Manager do Android Studio ou configure seu dispositivo Android para depuração USB.

Com o ambiente preparado, siga os passos abaixo:

#### Clone o Repositório do Front-end:

```sh
git clone https://github.com/ResidenciaTICBrisa/T2G3-Sistema-Instalacao-Eletrica.git
```

#### Abra o Projeto no Editor:
Abra a pasta clonada no Android Studio ou no Visual Studio Code.

#### Baixe as Dependências:
Abra um terminal na pasta `frontend/sige_ie` e execute o comando:

```sh
flutter pub get
```

#### Execute o Projeto:

- No Android Studio: Escolha um dispositivo ou emulador na barra de ferramentas e clique em 'Run'.
- No Visual Studio Code: Selecione um dispositivo ou emulador na barra de status e pressione `F5` ou utilize o comando `flutter run` na paleta de comandos.
```