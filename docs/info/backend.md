Claro! Aqui está o texto formatado em Markdown adequado para MkDocs em um único código contínuo:

```markdown
# Guia de Configuração do Back-end

## Estas etapas são válidas para Linux OS e WSL.

### Como subir o back-end:

#### Pela primeira vez

Primeiramente, interrompa qualquer processo que use o porto `8080`, `3306` e `6379`. Então atualize o seu sistema:

```sh
sudo apt-get update
sudo apt-get upgrade
```

Em seguida, caso já não tenha instalado:

#### Instale o Python, Pip e os cabeçalhos do Python e MySQL:

##### Python:

```sh
sudo apt-get install python3.11
```

##### Pip:

```sh
sudo apt-get install python3-pip
```

##### Cabeçalhos:

```sh
sudo apt-get install python3.11-dev default-libmysqlclient-dev build-essential pkg-config
```

#### Instale o virtualenv para criar um ambiente virtual do projeto:

##### Virtualenv:

```sh
sudo pip3 install virtualenv
```

#### Vá para dentro da pasta raiz `api`:

##### Cria o ambiente virtual e ative-o:

###### Criar ambiente virtual:

```sh
virtualenv -p python3.11 venv
```

###### Ativar ambiente:

```sh
source venv/bin/activate
```

#### Com o ambiente virtual ativado, instale as dependências:

```sh
pip install -r requirements.txt
```

#### Inicie o Docker, depois vá para o diretório `api/sigeie` e crie a imagem do banco de dados pela primeira vez:

```sh
docker-compose up -d
```

#### Ainda no mesmo terminal, retorne para o diretório raiz `api` e aplique as migrações:

```sh
python manage.py makemigrations
python manage.py migrate
```

#### Inicie o servidor:

```sh
python manage.py runserver
```

Pronto, o servidor já está rodando com o banco de dados configurado.

#### Pela segunda vez

Garanta que não haja nenhum processo que use o porto `8080`, `3306` e `6379`. Por fim, com todas as dependências configuradas, basta:

- Iniciar o Docker e o container `sigeie`;
- Baixar as atualizações (caso haja):

```sh
git pull
```

- Atualizar as dependências, fazer as migrações e iniciar o servidor:

```sh
source venv/bin/activate && pip install -r requirements.txt && python manage.py makemigrations && python manage.py migrate && python manage.py runserver
```

Isso é tudo, pessoal.
```