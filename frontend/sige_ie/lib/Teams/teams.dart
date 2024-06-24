import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';

class TeamsPage extends StatelessWidget {
  const TeamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.sigeIeBlue,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              decoration: const BoxDecoration(
                color: AppColors.sigeIeBlue,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: const Center(
                child: Column(
                  children: [
                    Text(
                      'Equipes',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: teams.length,
                    itemBuilder: (context, index) {
                      final team = teams[index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.group,
                              color: AppColors.sigeIeBlue),
                          title: Text(team.name),
                          subtitle: Text('Membros: ${team.members.length}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Lógica para sair da equipe
                            },
                          ),
                          onTap: () {
                            // Navegação para a página de detalhes da equipe
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final TextEditingController _controller = TextEditingController();
              return AlertDialog(
                title: const Text('Entrar em uma equipe'),
                content: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Digite o código da equipe',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Entrar'),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: AppColors.sigeIeYellow,
        child: const Icon(Icons.add, color: AppColors.sigeIeBlue),
      ),
    );
  }
}

class Team {
  final String name;
  final List<String> members;

  Team(this.name, this.members);
}

final List<Team> teams = [
  Team('Equipe 1', ['Membro 1', 'Membro 2', 'Membro 3']),
  Team('Equipe 2', ['Membro 4', 'Membro 5']),
  Team('Equipe 3', ['Membro 6', 'Membro 7', 'Membro 8']),
];
