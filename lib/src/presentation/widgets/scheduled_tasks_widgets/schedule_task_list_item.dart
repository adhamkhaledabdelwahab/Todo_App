import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/src/core/constants/task_model_const.dart';
import 'package:todo_app/src/core/routes/routes.dart';
import 'package:todo_app/src/data/models/task_model.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({Key? key, required this.task}) : super(key: key);

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      decoration: BoxDecoration(
        color: taskColors[task.color]!,
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      child: ListTile(
        onTap: () => Get.toNamed(
          taskScreenRouteFromScheduled,
          arguments: task,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            task.startTime,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        subtitle: Text(
          task.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              task.isFavourite == 1
                  ? Icons.favorite_outlined
                  : Icons.favorite_outline,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: task.isCompleted == 1
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 22,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
