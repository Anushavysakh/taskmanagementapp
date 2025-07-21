import 'package:flutter/material.dart';

import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  // Task collections
  final List<Task> _tasksList = [];
  final List<Task> _deletedTasks = [];

  List<Task> get tasksList =>
      _tasksList.where((task) => !task.isDeleted).toList();

  List<Task> get starredTasks =>
      _tasksList.where((task) => task.isStarred && !task.isDeleted).toList();

  List<Task> get deletedTasks => _deletedTasks;

  // Task creation state
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  TimeOfDay? _selectedTime;
  bool _isStarred = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Getters
  DateTime get focusedDay => _focusedDay;
  DateTime get selectedDay => _selectedDay;
  TimeOfDay? get selectedTime => _selectedTime;
  bool get isStarred => _isStarred;

  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;

  // State updaters
  void updateSelectedDay(DateTime selectedDay) {
    _selectedDay = selectedDay;
    notifyListeners();
  }

  void updateFocusedDay(DateTime focusedDay) {
    _focusedDay = focusedDay;
    notifyListeners();
  }

  void updateSelectedTime(TimeOfDay? selectedTime) {
    _selectedTime = selectedTime;
    notifyListeners();
  }

  void toggleStar() {
    _isStarred = !_isStarred;
    notifyListeners();
  }

  // Core: Add Task (FIXED)
  void addTask(Task newTask) {
    _tasksList.add(newTask);

    // Clear form state after saving
    _titleController.clear();
    _descriptionController.clear();
    _isStarred = false;
    _selectedTime = null;

    notifyListeners();
  }
  void moveToTrash(Task task){
    _tasksList.remove(task);
    _deletedTasks.add(task);
    notifyListeners();
  }
  void deleteTask(Task task) {
    _tasksList.remove(task);
    notifyListeners();
  }
}
