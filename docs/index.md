# Sigeie

<div align="center">
    <img src="assets/logo.png" style="width:30vw"/>
</div>

<h3 align="center">Sobre este projeto</h3>

Aplicativo web mobile desenvolvido para a Universidade de Brasília com objetivo de gerenciar as instalações elétricas e dar suporte ao retrofitting das instalações.

#### Posição

O SIGE IE é um sistema da Universidade de Brasília para o gerenciamento de instalações elétricas com o objetivo de facilitar o cadastro das informações de instalação elétrica para ajudar na reforma da parte elétrica dos prédios e salas. Ele permite a automatização da geração de relatórios das instalações elétricas de cada lugar e a centralização dessas informações para uso dos responsáveis pelas instalações. As pessoas devem usar o SIGE IE porque ele simplifica e agiliza o processo de gerenciamento, principalmente do retrofitting de instalações elétricas, garantindo maior eficiência e segurança.

#### Objetivos

Simplificar o cadastro e gerenciamento de informações de instalações elétricas e automatizar a geração de relatórios.

#### Tecnologias

##### Back-end

| Nome              | Versão | Uso               | Configuração                                                            |
|-------------------|--------|-------------------|-------------------------------------------------------------------------|
| Python            | 3.11.8 | Linguagem         | [Site oficial do Python](https://www.python.org/downloads/) |
| Django            | 4.2 (LTS) | Framework web    | Automática                                                              |
| Django REST framework | 3.14 | API REST       | Automática                                                              |
| Docker            | 25.0.4 | Conteiner e imagem | [Site oficial do Docker](https://docs.docker.com/desktop/install/ubuntu/) |
| Redis             | 7.2    | Banco de dados cache para sessão | Automática via Docker                                              |
| MySQL             | 8.1    | Banco de dados   | Automática via Docker                                                   |
| mysqlclient       | 2.2.4  | Cliente para se conectar com MySQL | [Site do Pypi com as configurações](https://pypi.org/project/mysqlclient/) |

###### Observação

Atualmente o Django REST Framework suporta as seguintes versões do Python e do Django:

| Python | 3.6 | 3.7 | 3.8 | 3.9 | 3.10 | 3.11 |
|--------|-----|-----|-----|-----|------|------|
| Django | 3.0 | 3.1 | 3.2 | 4.0 | 4.1  | 4.2 (LTS) |

Como a versão LTS mais recente do Django (2024) é a 4.2, escolhemos configurar o projeto usando Python 3.11.

##### Front-end mobile

| Nome          | Versão | Uso                | Configuração                                                 |
|---------------|--------|--------------------|--------------------------------------------------------------|
| Flutter       | 3.19.3 | Framework frontend | [Site oficial do Flutter](https://docs.flutter.dev/get-started/install/linux) |
| Android Studio| Iguana | IDE para desenvolvimento Android com Android SDK | [Site oficial do Android Studio](https://developer.android.com/studio/index.html) |

## Equipe

<table>
  <tr>    <td align="center"><a href="https://github.com/EngDann"><img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/137555908?v=4" width="100px;" alt=""/><br /><sub><b>Danilo Melo</b></sub></a><br />
    <td align="center"><a href="https://github.com/kauan2872"><img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/103394028?v=4" width="100px;" alt=""/><br /><sub><b>Kauan José</b></sub></a><br />
     <td align="center"><a href="https://github.com/OscarDeBrito"><img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/98489703?v=4" width="100px;" alt=""/><br /><sub><b>Oscar de Brito</b></sub></a><br />
    <td align="center"><a href="https://github.com/AlefMemTav"><img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/97984278?v=4" width="100px;" alt=""/><br /><sub><b>Pedro Lucas</b></sub></a><br />
    <td align="center"><a href="https://github.com/ramires31"><img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/139188097?v=4" width="100px;" alt=""/><br /><sub><b>Ramires</b></sub></a><br /><a href="Link git" title="Rocketseat"></a></td>
  </tr>
</table>