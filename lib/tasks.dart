import 'package:flutter/material.dart';
import 'package:tp2/models/task.dart'; // Importe le modèle de tâche
import 'package:tp2/widgets/new_task.dart'; // Importe le widget de création de nouvelle tâche
import 'package:tp2/widgets/tasks_list.dart'; // Importe le widget de la liste des tâches
import 'package:tp2/services/firestore.dart'; // Importe le service Firestore
import 'package:tp2/widgets/task_item.dart'; // Importe l'élément de tâche

// Classe Tasks qui étend StatefulWidget
class Tasks extends StatefulWidget {
  final VoidCallback? onSignOut; // Fonction de rappel pour la déconnexion

  const Tasks({Key? key, this.onSignOut}) : super(key: key); // Constructeur de la classe

  @override
  _TasksState createState() => _TasksState(); // Crée une instance de la classe TasksState
}

// Classe TasksState qui gère l'état de la classe Tasks
class _TasksState extends State<Tasks> {
  final FirestoreService firestoreService = FirestoreService(); // Instance du service Firestore
  final List<Task> _registeredTasks = []; // Liste pour stocker les tâches enregistrées, à mettre à jour avec la base de données

  // Fonction pour ouvrir l'overlay d'ajout de tâche
  void _openAddTaskOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewTask(onAddTask: _addTask), // Affiche le formulaire pour ajouter une nouvelle tâche
    );
  }

  // Fonction pour ajouter une tâche
  void _addTask(Task task) {
    setState(() {
      _registeredTasks.add(task); // Ajoute la tâche à la liste des tâches enregistrées
      firestoreService.addTask(task); // Ajoute la tâche à la base de données via le service Firestore
      Navigator.pop(context); // Ferme le formulaire d'ajout de tâche
    });
  }

  // Méthode pour construire l'interface utilisateur
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ToDoList'), // Titre de l'application
        actions: [
          IconButton(
            onPressed: () {
              if (widget.onSignOut != null) {
                widget.onSignOut!(); // Appelle la fonction de déconnexion si elle est définie
              }
            },
            icon: const Icon(Icons.logout), // Icône pour la déconnexion
          ),
          IconButton(
            onPressed: _openAddTaskOverlay, // Ouvre l'overlay d'ajout de tâche au clic
            icon: const Icon(Icons.add), // Icône pour ajouter une nouvelle tâche
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16), // Espacement intérieur du conteneur
        color: Colors.grey[200], // Couleur de fond du conteneur
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tasks', // Titre de la section des tâches
              style: TextStyle(
                fontSize: 24, // Taille de la police
                fontWeight: FontWeight.bold, // Poids de la police
                color: Colors.black, // Couleur du texte
              ),
            ),
            const SizedBox(height: 20), // Espace vertical
            Expanded(
              child: TasksList(
                tasks: _registeredTasks, // Affiche la liste des tâches enregistrées
              ),
            ),
          ],
        ),
      ),
    );
  }
}
