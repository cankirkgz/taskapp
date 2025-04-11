import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_app/models/task_model.dart';
import 'package:task_app/theme/app_theme.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
