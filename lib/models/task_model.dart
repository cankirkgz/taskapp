import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  String category;

  @HiveField(4)
  String priority;

  @HiveField(5)
  bool isDone;

  Task({
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    this.isDone = false,
  });
}
