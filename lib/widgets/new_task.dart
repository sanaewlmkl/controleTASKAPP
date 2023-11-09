import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importe le package pour formater les dates
import 'package:tp2/models/task.dart'; // Importe le modèle de tâche

// Classe NewTask qui étend StatefulWidget pour gérer la création d'une nouvelle tâche
class NewTask extends StatefulWidget {
  const NewTask({Key? key, required this.onAddTask}) : super(key: key); // Constructeur prenant une fonction de rappel pour ajouter une tâche
  final void Function(Task task) onAddTask; // Fonction pour ajouter une tâche

  @override
  _NewTaskState createState() => _NewTaskState(); // Crée une instance de la classe _NewTaskState
}

// Classe _NewTaskState pour gérer l'état de la classe NewTask
class _NewTaskState extends State<NewTask> {
  Category _selectedCategory = Category.personal; // Déclaration de la catégorie sélectionnée

  final _titleController = TextEditingController(); // Contrôleur pour le champ de saisie du titre
  final _descriptionController = TextEditingController(); // Contrôleur pour le champ de saisie de la description
  DateTime _selectedDate = DateTime.now(); // Déclaration de la date sélectionnée

  @override
  void dispose() {
    _titleController.dispose(); // Libère les ressources du contrôleur du titre
    _descriptionController.dispose(); // Libère les ressources du contrôleur de la description
    super.dispose();
  }

  var _enteredTitle = ''; // Variable pour stocker le titre
  var _enteredDescription = ''; // Variable pour stocker la description

  void _saveTitleInput(String inputValue) {
    _enteredTitle = inputValue; // Enregistre la valeur saisie pour le titre
  }

  void _submitTaskData() {
    if (_titleController.text.trim().isEmpty) { // Vérifie si le champ de saisie du titre est vide
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur'), // Titre de la boîte de dialogue d'erreur
          content: const Text(
              'Merci de saisir le titre de la tâche à ajouter dans la liste'), // Message d'erreur
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); // Ferme la boîte de dialogue
              },
              child: const Text('Okay'), // Bouton pour fermer la boîte de dialogue
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddTask(Task( // Appelle la fonction de rappel pour ajouter une nouvelle tâche avec les détails saisis
      title: _titleController.text,
      description: _descriptionController.text,
      date: _selectedDate,
      category: _selectedCategory,
    ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate, // Date initiale pour le sélecteur de date
      firstDate: DateTime(2023), // Première date autorisée
      lastDate: DateTime(2024), // Dernière date autorisée
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked; // Met à jour la date sélectionnée
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16), // Espacement intérieur du conteneur
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _titleController, // Utilise le contrôleur pour le champ de saisie du titre
            decoration: const InputDecoration(
              labelText: 'Title', // Étiquette du champ de saisie du titre
            ),
          ),
          TextFormField(
            controller: _descriptionController, // Utilise le contrôleur pour le champ de saisie de la description
            decoration: const InputDecoration(
              labelText: 'Description', // Étiquette du champ de saisie de la description
            ),
          ),
          const SizedBox(height: 10), // Espace vertical
          InkWell(
            onTap: () => _selectDate(context), // Appelle la méthode pour sélectionner la date au clic
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Date', // Étiquette du champ de saisie de la date
                border: OutlineInputBorder(), // Bordure du champ de saisie
              ),
              child: Text(
                DateFormat.yMMMd().format(_selectedDate), // Formate la date sélectionnée
              ),
            ),
          ),
          const SizedBox(height: 10), // Espace vertical
          DropdownButton<Category>( // Menu déroulant pour sélectionner la catégorie de la tâche
            value: _selectedCategory, // Valeur sélectionnée
            items: Category.values.map((category) { // Liste des éléments du menu déroulant
              return DropdownMenuItem<Category>(
                value: category, // Valeur de l'élément
                child: Text(
                  category.toString().toUpperCase(), // Texte de l'élément en majuscules
                ),
              );
            }).toList(),
            onChanged: (Category? newValue) { // Fonction appelée lorsqu'une nouvelle valeur est sélectionnée dans le menu déroulant
              if (newValue != null) {
                setState(() {
                  _selectedCategory = newValue; // Met à jour la catégorie sélectionnée
                });
              }
            },
          ),
          const SizedBox(height: 20), // Espace vertical
          ElevatedButton( // Bouton pour enregistrer la tâche
            onPressed: _submitTaskData, // Appelle la méthode pour soumettre les données de la tâche
            child: const Text('Save Task'), // Texte du bouton
          ),
        ],
      ),
    );
  }
}
