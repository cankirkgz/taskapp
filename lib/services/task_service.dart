import 'package:hive/hive.dart';
import 'package:task_app/models/task_model.dart';

class TaskService {
  static const String boxName = 'tasks';

  Future<void> addTask(Task task) async {
    final box = Hive.box<Task>(boxName);
    await box.add(task);
  }

  Future<List<Task>> getAllTasks() async {
    final box = Hive.box<Task>(boxName);
    return box.values.toList();
  }

  Future<void> updateTask(int index, Task updatedTask) async {
    final box = Hive.box<Task>(boxName);
    await box.putAt(index, updatedTask);
  }

  Future<void> deleteTask(int index) async {
    final box = Hive.box<Task>(boxName);
    await box.deleteAt(index);
  }
}
