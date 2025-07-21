import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay? time;
  bool isStarred;
  bool isDeleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.time,
    this.isStarred = false,
    this.isDeleted = false,
  });
}
