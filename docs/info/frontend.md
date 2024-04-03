#### Como Subir o Front-end:

Antes de começar, verifique se o Flutter SDK está atualizado e compatível com o projeto. Siga as instruções específicas para sua plataforma (Windows, macOS, Linux) disponíveis na [documentação oficial do Flutter](https://flutter.dev/docs/get-started/install).

Caso ainda não tenha feito, instale os seguintes requisitos em sua máquina:

- **Flutter SDK**:
  Siga as instruções de instalação para a sua plataforma.

- **Android Studio ou Visual Studio Code**:

  - Android Studio:
    ```
    sudo snap install android-studio --classic
    ```

  - Visual Studio Code:
    ```
    sudo snap install code --classic
    ```
  Para o VS Code, instale as extensões do Flutter e Dart disponíveis na aba de extensões do editor.

- **Emulador Android ou um dispositivo físico**:
  Configure um emulador usando o AVD Manager do Android Studio ou [configure seu dispositivo Android para depuração USB](https://developer.android.com/studio/debug/dev-options). 

Com o ambiente preparado, siga os passos abaixo:

1. **Clone o Repositório do Front-end**:
    ```
    git clone https://github.com/ResidenciaTICBrisa/T2G3-Sistema-Instalacao-Eletrica.git
    ```

2. **Abra o Projeto no Editor**:
    Abra a pasta clonada no Android Studio ou no Visual Studio Code.

3. **Baixe as Dependências**:
    Abra um terminal no editor e execute o comando:
    ```
    flutter pub get
    ```

4. **Execute o Projeto**:
    - **No Android Studio:** Escolha um dispositivo ou emulador na barra de ferramentas e clique em 'Run'.
    - **No Visual Studio Code:** Selecione um dispositivo ou emulador na barra de status e pressione `F5` ou utilize o comando `Flutter: Run` na paleta de comandos.

Pronto, o Front end já está rodando e você pode utilizá-lo.


