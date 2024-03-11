<h1 align="center">

SIGE IE
</h1>

### Fase do projeto
Release 1 <a href="https://github.com/ResidenciaTICBrisa/T2G3-Sistema-Instalacao-Eletrica/milestone/1">Ir para milestone da release 1</a>

### Sobre este projeto
O projeto é um aplicativo web mobile desenvolvido para a Universidade de Brasília para o gerenciamento de instalações elétricas.
#### Posição
O SIGE IE é um sistema da Universidade de Brasília para o gerenciamento de instalações elétricas com o objetivo de facilitar o cadastro das informações de instalação elétrica, sendo acessível tanto para uma pessoa comum quanto para um profissional da área. Ele permite a automatização da geração de relatórios das instalações elétricas para um determinado lugar e a gerencia dessas informações por parte dos responsáveis pelas instalações deste lugar. As pessoas devem usar o SIGE IE porque ele simplifica e agiliza o processo de gerenciamento de instalações elétricas, garantindo maior eficiência e segurança nas operações.

#### Objetivos
Simplificar o cadastro e gerenciamento de informações de instalações elétricas e automatizar a geração de relatórios.
#### Tecnologias
##### Back-end
<div align="center">
  
| Nome | Versão | Uso | Configuração |
|---|---|---|---|
| Python | 3.11.8| Linguagem | [Site oficial do Python](https://www.python.org/downloads/) |
| Django | 4.2 | Framework web | [Site oficial do Django](https://www.djangoproject.com/download/) |
| Django REST framework | 3.14 | API REST | [Site oficial do Django REST framework](https://www.django-rest-framework.org/#installation) |
| Docker | 25.0.4 | Conteiner e imagem | [Site oficial do Docker](https://docs.docker.com/desktop/install/ubuntu/) |
| Redis | 7.2 | Banco de dados cache para sessão | Automático via Docker |
| MySQL | 8.1 | Banco de dados | Automático via Docker |


</div>

##### Front-end mobile

<div align="center">
  
| Nome | Versão | Uso | Configuração |
|---|---|---|---|
| Flutter | 3.19.3 | Framework frontend | [Site oficial do Flutter](https://docs.flutter.dev/get-started/install/linux) |
| Android Studio | Iguana | IDE para desenvolvimento Android com Android SDK | [Site oficial do Android Studio](https://developer.android.com/studio/index.html) |


  
</div>

### Contribuidores 
<div align="center">
  <table>
    <tbody>
      <tr>
        <td>AlefMemTav</td>
        <td>Pedro Lucas</td>
        <td><img src="https://avatars.githubusercontent.com/u/97984278?v=4" alt="Contribuidor" width="42px;" ></td>
      </tr>
      <tr>
        <td>EngDann</td>
        <td>Danilo</td>
        <td><img src="https://avatars.githubusercontent.com/u/137555908?v=4" alt="Contribuidor" width="42px;" ></td>
      </tr>
      <tr>
        <td>kauan2872</td>
        <td>Kauan</td>
        <td><img src="https://avatars.githubusercontent.com/u/103394028?v=4" alt="Contribuidor" width="42px;" ></td>
      </tr>
      <tr>
        <td>OscarDeBrito</td>
        <td>Oscar</td>
        <td><img src="https://avatars.githubusercontent.com/u/98489703?v=4" alt="Contribuidor" width="42px;" ></td>
      </tr>
      <tr>
        <td>ramires31</td>
        <td>Ramires</td>
        <td><img src="https://avatars.githubusercontent.com/u/139188097?v=4" alt="Contribuidor" width="42px;" ></td>
      </tr>
    </tbody>
  </table>
</div>

### Como subir o projeto
Estas etapas são válidas para Linux OS e WSL.
#### Como subir o back-end:

Primeiramente, interrompa qualquer processo que use o porto 8080 e 3306.

1. Instale o python e pip:

   `sudo apt-get install python3.11`

   `sudo apt-get install python3-pip`

2. Instale o virutalenv para criar um ambiente virtual para instalar todas as dependências e ative ele:

   `pip install virtualenv`
   
   `virtualenv -p python3.11 venv`

   `source venv/bin/activate`

3. Com o ambiente virtual ativado, instale as dependências:

   `pip install -r ./api/requirements.txt`

4. Com o docker iniciado, crie a imagem do banco de dados pela primeira vez. (Depois não será mais necessário criar a imagem):

    `docker-compose build`

5. Suba a imagem:

    `docker-compose up`

6. Ainda no diretório raiz `api`, aplique as migrações: 

    `python3 manage.py migrate`

5. Inicie o servidor:

   `python3 manage.py runserver`

Pronto, o servidor já está rodando com o banco de dados configurado.
#### Como subir o front-end:

### Como contribuir
1. Faça um fork do repositório do projeto.
2. Clone o fork na sua máquina:
   
   `git clone https://github.com/{seu-usuario}/T2G3-Sistema-Instalacao-Eletrica.git`
   
3. Comente na issue que deseja contribuir ou crie uma issue nova.
4. Entre no repositório clonado na sua máquina:
    
   `cd T2G3-Sistema-Instalacao-Eletrica`
   
5. Após enviar suas contribuições para o fork do seu repositório, faça um pull request.
6. Aguarde a revisão. 

### Documentação
- [Cronograma](https://github.com/ResidenciaTICBrisa/T2G3-Sistema-Instalacao-Eletrica/issues/3)
- [Requisitos](https://github.com/ResidenciaTICBrisa/T2G3-Sistema-Instalacao-Eletrica/issues/1)
- [Arquitetura](https://github.com/ResidenciaTICBrisa/T2G3-Sistema-Instalacao-Eletrica/issues/2)
- [Atas de reunião](https://github.com/ResidenciaTICBrisa/T2G3-Sistema-Instalacao-Eletrica/issues/4)
