import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/task_provider.dart';
import '../resuable_widgets/custom_calendar.dart';



class StarredPage extends StatelessWidget {
  const StarredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TaskProvider>(builder: (context, value, child) {
        return Container(
          padding: EdgeInsets.all(8),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              CustomCalendar(
                focusedDay: value.focusedDay,
                selectedDay: value.selectedDay,
                onDaySelected: (selectedDay, focusedDay) {
                  value.updateSelectedDay(selectedDay);
                  value.updateFocusedDay(focusedDay);
                },
                onPageChanged: (focusedDay) {
                  value.updateFocusedDay(focusedDay);
                },
              ),
              SizedBox(height: 20),
              Text(
                'Today\'s Tasks',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: value.tasksList.isEmpty
                    ? Center(
                  child: Text(
                    'Add Notes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: value.tasksList.length,
                  itemBuilder: (context, index) {
                    final task = value.tasksList[index];
                    return Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Icon(Icons.star, color: Colors.yellow),
                          ),
                          Text(
                            task.title,
                            style: TextStyle(color: Colors.red),
                          ),
                          SizedBox(height: 10),
                          Text(
                            task.description,
                            style: TextStyle(color: Colors.yellow),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}