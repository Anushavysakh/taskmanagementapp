import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime selectedDay;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(DateTime) onPageChanged;

  const CustomCalendar({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      firstDay: DateTime.now().subtract(Duration(days: 345)),
      lastDay: DateTime.now().add(Duration(days: 30)),
      calendarFormat: CalendarFormat.week,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.white),
        weekendStyle: TextStyle(color: Colors.red),
      ),
      availableGestures: AvailableGestures.horizontalSwipe,
      pageAnimationEnabled: true,
      headerStyle: HeaderStyle(
        titleTextStyle: TextStyle(color: Colors.white),
        formatButtonVisible: false,
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
      ),
      calendarStyle: CalendarStyle(
        defaultTextStyle: TextStyle(color: Colors.white),
        selectedDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,

        ),
        todayDecoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
      ),
      onDaySelected: onDaySelected,
      onPageChanged: onPageChanged,
    );
  }
}