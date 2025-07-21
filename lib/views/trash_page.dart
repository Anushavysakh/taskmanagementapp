import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/task_provider.dart';
import '../resuable_widgets/resuablewidgets.dart';

class TrashPage extends StatelessWidget {
  TrashPage({super.key});

  ReusableWidgets reusableWidgets = ReusableWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TaskProvider>(
        builder: (context, value, child) {
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
                SizedBox(height: 120),
                Row(
                  children: [
                    Text(
                      'Trash',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),SizedBox(width: 10,),
                    Icon(
                      Icons.delete_outline_outlined,
                      color: Colors.amberAccent,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: value.tasksList.isEmpty
                      ? Center(
                          child: Text(
                            'No data available',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : reusableWidgets.cardList(
                          value.tasksList,
                          isTrashScreen: true,
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
