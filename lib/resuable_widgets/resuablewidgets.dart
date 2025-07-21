import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../provider/task_provider.dart';

class ReusableWidgets {
  Widget cardList(List<Task> tasksForSelectedDate, {required bool isTrashScreen}) {
    return ListView.builder(
      itemCount: tasksForSelectedDate.length,
      itemBuilder: (context, index) {
        final task = tasksForSelectedDate[index];

        return Dismissible(
          key: Key(task.id.toString()),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) async {
            final taskProvider = Provider.of<TaskProvider>(context, listen: false);

            if (isTrashScreen) {
               taskProvider.deleteTask(task); // Permanently delete
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${task.title} deleted permanently")),
              );
            } else {
               taskProvider.moveToTrash(task); // Move to trash
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${task.title} moved to trash")),
              );
            }
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: Card(
            color: Colors.white12,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              title: Text(
                task.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.time != null ? "Time: ${task.time}" : "No time set",
                    style: const TextStyle(color: Colors.purpleAccent),
                  ),
                ],
              ),
              trailing: task.isStarred
                  ? const Icon(Icons.star, color: Colors.yellow)
                  : const Icon(Icons.star_border, color: Colors.grey),
              tileColor: Colors.transparent,
            ),
          ),
        );
      },
    );
  }
}
