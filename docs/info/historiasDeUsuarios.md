#  História de Usuário

Aqui estão as histórias de usuários mapeadas pelos épicos e features conforme o método SAFe.

| Épico | Feature | Número | Prioridade | Título | Descrição | Critérios de aceitação |
| --- | --- | --- | --- | --- | --- | --- | 
| E1 | F1 | US1 | Alta | Cadastrar Usuário | Como usuário quero cadastrar no sistema para utilizar seus recursos e funcionalidades disponíveis | Atributos obrigatórios: id, nome, nome de usuário, e-mail, senha, está ativo, data de criação, grupos; <br><br> Os atributos nome de usuário e senha devem ter no mínimo 6 caracteres, e no máximo 23 e 200 caracteres, respectivamente; <br><br> Os atributos está ativo, data de criação são automáticos; A senha deve ser criptografada;<br><br> Os grupos são: criador, editor, usuário;<br><br> Observações: <br><br> Um usuário pertence ao grupo usuário quando cria uma nova conta; <br><br> Um usuário pertence ao grupo criador quando cria um lugar; <br><br> Um usuário pertence ao grupo editor quando edita um lugar; <br><br> |
| E1 | F1 | US2 | Alta | Visualizar Usuário |Como um usuário registrado, quero visualizar minhas informações de conta para que eu possa revisar e atualizar meus dados conforme necessário | Critérios de aceitação: <br><br> Deve-se visualizar as informações nome, nome de usuário, e-mail;  <br><br> Não deve ser permitida a visualização da senha, em nenhuma hipótese;   <br><br> |
| E1 | F1 | US3 | Alta | Editar Usuário |Como usuário quero editar o meu perfil no sistema para atualizar meus dados.|Critérios de aceitação:<br><br>Editar atributos obrigatórios: Nome, e-mail <br><br> |
| E1 | F1 | US4 | Alta | Excluir Conta | Como um usuário do aplicativo, quero excluir minha conta, para não disponibilizar mais minhas informações no sistema nem utilizar mais seus serviços.|Critérios de aceitação:<br><br>Ao selecionar a opção de exclusão de conta, o usuário deve ser solicitado a confirmar sua escolha; <br><br>Após a confirmação da exclusão da conta, todos os dados pessoais do usuário devem ser removidos do sistema;<br><br> |


