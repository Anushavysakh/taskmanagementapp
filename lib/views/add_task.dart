import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../provider/task_provider.dart';
import '../resuable_widgets/custom_calendar.dart';
import '../models/task_model.dart';
import '../resuable_widgets/resuablewidgets.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  TimeOfDay? _selectedTime;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  ReusableWidgets reusableWidgets = ReusableWidgets();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Consumer<TaskProvider>(
            builder: (context, value, child) {
              final tasksForSelectedDate = value.tasksList
                  .where((task) => isSameDay(task.date, value.selectedDay))
                  .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),

                  // Calendar
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomCalendar(
                      focusedDay: _focusedDay,
                      selectedDay: _selectedDay,
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                        value.updateSelectedDay(selectedDay); // optional
                      },
                      onPageChanged: (focusedDay) {
                        setState(() {
                          _focusedDay = focusedDay;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tasks List
                  Container(
                    height: screenHeight * 0.25,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: value.tasksList.isEmpty
                        ? const Center(
                            child: Text(
                              "No tasks available",
                              style: TextStyle(color: Colors.white70),
                            ),
                          )
                        :reusableWidgets.cardList(tasksForSelectedDate, isTrashScreen: false)


                  ),

                  const SizedBox(height: 20),

                  // Add Task Form
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Star toggle
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(
                              value.isStarred ? Icons.star : Icons.star_border,
                              color: Colors.yellow,
                            ),
                            onPressed: value.toggleStar,
                          ),
                        ),

                        // Title
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            hintText: "Title",
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),

                        const SizedBox(height: 10),

                        // Description
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            hintText: "Description",
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          style: const TextStyle(color: Colors.white),
                          maxLines: 2,
                        ),

                        const SizedBox(height: 20),

                        // Time Picker
                        GestureDetector(
                          onTap: () => _selectTime(context),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                color: Colors.purple,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                _selectedTime == null
                                    ? "Select your time"
                                    : _selectedTime!.format(context),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Save button
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_titleController.text.isEmpty ||
                                  _descriptionController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please fill in all fields"),
                                  ),
                                );
                                return;
                              }

                              final newTask = Task(
                                id: DateTime.now().toString(),
                                title: _titleController.text.trim(),
                                description: _descriptionController.text.trim(),
                                date: _selectedDay,
                                isStarred: value.isStarred,
                                time: _selectedTime, // if needed
                              );
                              value.addTask(newTask);
                              print(newTask.title);
                              _titleController.clear();
                              _descriptionController.clear();
                              // setState(() {
                              //   _selectedTime = null;
                              // });

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Task added")),
                              );
                            },
                            child: const Text("SAVE"),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
}
