import 'package:flutter/material.dart';
import 'package:task_app/pages/add_task_page.dart';
import 'package:task_app/services/task_service.dart';
import 'package:task_app/widgets/task_card.dart';
import '../models/task_model.dart';

enum TaskFilter { all, completed, incomplete }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskService _taskService = TaskService();
  TaskFilter _currentFilter = TaskFilter.all;
  List<Task> _tasks = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  List<Task> get _filteredTasks {
    List<Task> filtered = switch (_currentFilter) {
      TaskFilter.completed => _tasks.where((task) => task.isDone).toList(),
      TaskFilter.incomplete => _tasks.where((task) => !task.isDone).toList(),
      TaskFilter.all => _tasks,
    };

    if (_searchController.text.trim().isNotEmpty) {
      filtered = filtered
          .where((task) => task.title
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    }

    return filtered;
  }

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadTasks() async {
    final tasks = await _taskService.getAllTasks();
    setState(() => _tasks = tasks);
  }

  void _deleteTask(int index) async {
    await _taskService.deleteTask(index);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                onChanged: (value) => setState(() {}),
                decoration: InputDecoration(
                  hintText: "Görev ara...",
                  border: InputBorder.none,
                ),
              )
            : const Text("Görevlerim"),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchController.clear();
                }
                _isSearching = !_isSearching;
              });
            },
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterButton("Tümü", TaskFilter.all, Icons.layers),
                  const SizedBox(width: 12),
                  _buildFilterButton(
                      "Tamamlananlar", TaskFilter.completed, Icons.check),
                  const SizedBox(width: 12),
                  _buildFilterButton("Tamamlanmayanlar", TaskFilter.incomplete,
                      Icons.circle_outlined),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _filteredTasks.isEmpty
              ? const Expanded(
                  child: Center(child: Text("Hiç görev bulunamadı.")))
              : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    itemCount: _filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = _filteredTasks[index];
                      return Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddTaskPage(
                                    isEditMode: true,
                                    task: task,
                                  ),
                                ),
                              );
                              if (result == "updated") {
                                _loadTasks();
                              }
                            },
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Görevi Sil"),
                                  content: const Text(
                                      "Bu görevi silmek istediğine emin misin?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Hayır"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _deleteTask(index);
                                      },
                                      child: const Text("Evet"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: TaskCard(
                              title: task.title,
                              description: task.description,
                              category: task.category,
                              priority: task.priority,
                              isCompleted: task.isDone,
                              onCompletedChanged: (value) {
                                task.isDone = value;
                                task.save();
                                _loadTasks();
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskPage()),
          );
          if (result != null && result is Task) {
            await _taskService.addTask(result);
            _loadTasks();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterButton(String label, TaskFilter filter, IconData icon) {
    final isSelected = _currentFilter == filter;

    final List<Color> selectedGradient = [Color(0xFF2563EB), Color(0xFF4F46E5)];
    final List<Color> unselectedGradient = [
      Color(0xFFF3F4F6),
      Color(0xFFE5E7EB)
    ];

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentFilter = filter;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected ? selectedGradient : unselectedGradient,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 18, color: isSelected ? Colors.white : Colors.black87),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.0,
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
