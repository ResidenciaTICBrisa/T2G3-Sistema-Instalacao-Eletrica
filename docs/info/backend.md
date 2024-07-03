# Como Subir o Projeto

Estas etapas são válidas para Linux OS e WSL.

## Como Subir o Backend

1. **Atualização do Sistema:**

    Primeiramente, interrompa qualquer processo que utilize as portas 8080, 3306 e 6379. Em seguida, atualize o sistema:

    ```bash
    sudo apt-get update
    sudo apt-get upgrade
    ```

2. **Instalação de Dependências:**

    - Instale o Python 3.11, Pip e os cabeçalhos necessários:

        ```bash
        sudo apt-get install python3.11
        sudo apt-get install python3-pip python3.11-dev default-libmysqlclient-dev build-essential pkg-config
        ```

    - Instale o `mysqlclient`:

        ```bash
        pip install mysqlclient
        ```

3. **Instalação do Virtualenv:**

    - Instale o `virtualenv` para gerenciar ambientes virtuais:

        ```bash
        sudo pip3 install virtualenv
        ```

4. **Configuração do Ambiente Virtual:**

    - Vá para o diretório raiz do projeto `api`:

        ```bash
        cd caminho/para/o/diretorio/api
        ```

    - Crie e ative o ambiente virtual:

        ```bash
        virtualenv -p python3.11 venv
        source venv/bin/activate
        ```

5. **Instalação de Dependências do Projeto:**

    - Com o ambiente virtual ativado, instale as dependências listadas no arquivo `requirements.txt`:

        ```bash
        pip install -r requirements.txt
        ```

6. **Configuração do Banco de Dados com Docker:**

    - Com o Docker iniciado, construa a imagem do banco de dados:

        ```bash
        docker-compose build
        ```

7. **Iniciar Docker:**

    - Suba o contêiner do banco de dados:

        ```bash
        docker-compose up
        ```

8. **Aplicação de Migrações:**

    - Ainda no diretório raiz `api`, aplique as migrações ao banco de dados:

        ```bash
        python manage.py makemigrations
        python manage.py migrate
        ```

9. **Iniciar o Servidor:**

    - Finalmente, inicie o servidor Django:

        ```bash
        python manage.py runserver
        ```

Pronto! O servidor está configurado e em execução com o banco de dados configurado.
