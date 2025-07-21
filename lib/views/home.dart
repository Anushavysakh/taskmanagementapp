import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../provider/task_provider.dart';
import '../resuable_widgets/custom_calendar.dart';
import '../resuable_widgets/resuablewidgets.dart';

class Home extends StatelessWidget {
   Home({super.key});

 final  reusableWidgets = ReusableWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Consumer<TaskProvider>(
        builder: (context, value, child) {
          final tasksForSelectedDate = value.tasksList
              .where((task) => isSameDay(task.date, value.selectedDay))
              .toList();

          return Column(
            children: [Container(
           //   height: MediaQuery.of(context).size.height * 0.2,
              padding: const EdgeInsets.only(top: 50, right: 15),
              color: Colors.amberAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Popup menu button
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'profile') {
                        // Navigate to profile update screen
                      } else if (value == 'info') {
                        // Show app info dialog
                      } else if (value == 'logout') {
                        // Handle logout logic
                      }
                    },
                    icon: Icon(Icons.menu, size: 28, color: Colors.black87),
                    itemBuilder: (context) => [
                      PopupMenuItem(value: 'profile', child: Text('Profile Update')),
                      PopupMenuItem(value: 'info', child: Text('App Info')),
                      PopupMenuItem(value: 'logout', child: Text('Logout')),
                    ],
                  ),


                  // Circle Avatar
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person,), // Use your image or a NetworkImage
                  ),
                ],
              ),
            ),

              Container(
            //    height: MediaQuery.of(context).size.height * 0.2,
                color: Colors.amberAccent,
                alignment: Alignment.bottomLeft,
                child: Padding(padding: EdgeInsetsGeometry.only(top: 8,left: 40),
                //  padding: const EdgeInsets.only(top: 15.0, left: 9.0),
                  child: Text(
                    "Hi Anusha,",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: Container(
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
                      //    SizedBox(height: 10),
                      Expanded(
                        child: tasksForSelectedDate.isEmpty
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
                            : reusableWidgets.cardList(
                                tasksForSelectedDate,
                                isTrashScreen: false,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
