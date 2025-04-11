import 'package:flutter/material.dart';
import 'package:task_app/models/task_model.dart';
import 'package:task_app/theme/app_colors.dart';
import 'package:task_app/widgets/category_dropdown.dart';
import 'package:task_app/widgets/custom_text_field.dart';
import 'package:task_app/widgets/priority_selector.dart';
import 'package:task_app/widgets/task_card.dart';
import 'package:task_app/widgets/custom_button.dart';

class AddTaskPage extends StatefulWidget {
  final bool isEditMode;
  final Task? task;
  const AddTaskPage({
    super.key,
    this.isEditMode = false,
    this.task,
  });

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  final List<String> _categories = [
    'İş',
    'Kişisel',
    'Sağlık',
    'Finans',
    'Alışveriş'
  ];
  String? _selectedCategory;
  String _selectedPriority = "Düşük";

  bool get isAllFieldsFilled =>
      _titleController.text.trim().isNotEmpty &&
      _descriptionController.text.trim().isNotEmpty &&
      (_selectedCategory?.trim().isNotEmpty ?? false) &&
      _selectedPriority.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(
        text: widget.isEditMode ? widget.task!.title : "");
    _descriptionController = TextEditingController(
        text: widget.isEditMode ? widget.task!.description : "");

    _selectedCategory = widget.isEditMode ? widget.task!.category : null;
    _selectedPriority = widget.isEditMode ? widget.task!.priority : "Düşük";

    _titleController.addListener(() => setState(() {}));
    _descriptionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni Görev Oluştur"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Görev Başlığı",
                      style: TextStyle(
                          color: AppColors.titleColor, fontSize: 18.0)),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _titleController,
                    hintText: 'Bir görev başlığı gir',
                  ),
                  const SizedBox(height: 25),
                  Text("Açıklama",
                      style: TextStyle(
                          color: AppColors.titleColor, fontSize: 18.0)),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _descriptionController,
                    hintText: 'Görevin detaylarını yaz',
                    maxLines: 4,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "Kategori",
                    style:
                        TextStyle(color: AppColors.titleColor, fontSize: 18.0),
                  ),
                  const SizedBox(height: 10),
                  CategoryDropdown(
                    selectedCategory: _selectedCategory,
                    categories: _categories,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "Öncelik",
                    style:
                        TextStyle(color: AppColors.titleColor, fontSize: 18.0),
                  ),
                  const SizedBox(height: 10),
                  PrioritySelector(
                    selectedPriority: _selectedPriority,
                    onPriorityChanged: (priority) {
                      setState(() {
                        _selectedPriority = priority;
                      });
                    },
                  ),
                  const SizedBox(height: 25),
                  if (isAllFieldsFilled)
                    TaskCard(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      category: _selectedCategory ?? '',
                      priority: _selectedPriority,
                      isCompleted: false,
                      isPreview: true,
                      onCompletedChanged: (value) {},
                    ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    label: "İptal Et",
                    onPressed: () => Navigator.pop(context),
                    backgroundColor: AppColors.cancelButton,
                    textColor: Colors.grey,
                    showShadow: false,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    label: widget.isEditMode ? "Güncelle" : "Görevi Kaydet",
                    onPressed: () {
                      if (isAllFieldsFilled) {
                        if (widget.isEditMode && widget.task != null) {
                          widget.task!
                            ..title = _titleController.text
                            ..description = _descriptionController.text
                            ..category = _selectedCategory ?? ''
                            ..priority = _selectedPriority;
                          widget.task!.save();
                          Navigator.pop(context, "updated");
                        } else {
                          final newTask = Task(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            category: _selectedCategory ?? '',
                            priority: _selectedPriority,
                          );
                          Navigator.pop(context, newTask);
                        }
                      }
                    },
                    backgroundColor: AppColors.confirmButton,
                    textColor: Colors.white,
                    showShadow: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
