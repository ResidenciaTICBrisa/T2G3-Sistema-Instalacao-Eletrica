### Como subir o projeto
Estas etapas são válidas para Linux OS e WSL.
#### Como subir o back-end:

Primeiramente, interrompa qualquer processo que use o porto 8080, 3306 e 6379. Então atualize o seu sistema:
  ```
  sudo apt-get update
  ```

  ```
  sudo apt-get upgrade
  ```

Em seguida, caso já não tenha instalado:

- Instale o Python, Pip e os cabeçalhos do Python e MySQL:

  Python:
  ```
  sudo apt-get install python3.11
  ```

  Pip:
  ```
   sudo apt-get install python3-pip
  ```

  Cabeçalhos:
  ```
  sudo apt-get install python3.11-dev default-libmysqlclient-dev build-essential pkg-config
  ```

   mysqlclient:

   ```
   pip install mysqlclient
   ```

- Instale o virtualenv para criar um ambiente virtual do projeto:

    Virtualenv:
    ```
    sudo pip3 install virtualenv
    ```

Vá para dentro da pasta raiz `api`:

1. Cria o ambiente virtual e ative-o:

    Criar ambiente virtual:
     ```
     virtualenv -p python3.11 venv
     ``` 
  
    Ativar ambiente:
     ```
     source venv/bin/activate
     ``` 

3. Com o ambiente virtual ativado, instale as dependências:

   ```
   pip install -r requirements.txt
   ```

4. Com o docker iniciado, crie a imagem do banco de dados pela primeira vez:

   ```
   docker-compose build
   ```

6. Suba a imagem:

   ```
   docker-compose up
   ```

8. Ainda no diretório raiz `api`, aplique as migrações:

   ```
   python manage.py makemigrations
   ```

   ```
   python3 manage.py migrate
   ```

10. Inicie o servidor:

    ```
    python3 manage.py runserver
    ```

Pronto, o servidor já está rodando com o banco de dados configurado.
