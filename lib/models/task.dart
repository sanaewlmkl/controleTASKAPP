
import 'package:uuid/uuid.dart';

enum Category { personal, work, shopping, others }

class Task {
  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    this.isCompleted = false, // Définir isCompleted avec une valeur par défaut
  }) : id = const Uuid().v4();

  final String id;
  final String title;
  final String description;
  final DateTime date;
  final Category category;
  bool isCompleted; // Ajout du paramètre isCompleted
}
