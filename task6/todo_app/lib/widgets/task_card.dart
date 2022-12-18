import 'package:flutter/material.dart';
import 'package:todo_app/common/app_colors.dart';

import '../model/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Function(Task) onDelete;
  final Function(Task) onToggle;

  const TaskCard({
    Key? key,
    required this.task,
    required this.onDelete,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id),
      onDismissed: (_) {
        onDelete(task);
      },
      child: GestureDetector(
        onLongPress: () {
          onToggle(task);
        },
        child: Stack(
          children: <Widget>[
            Container(
              width: 380,
              height: 100,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: task.isDone
                    ? AppColors.doneTaskCardColor
                    : AppColors.cardBackground,
              ),
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 20),
                  Checkbox(
                      value: task.isDone,
                      onChanged: (_) {
                        onToggle(task);
                      }),
                  const SizedBox(width: 10),
                  const VerticalDivider(
                      color: Colors.grey, indent: 12, endIndent: 12),
                  const SizedBox(width: 10),
                  Text(task.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w300)),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
