import 'package:flutter/material.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/presentation/widgets/scheduled_tasks_widgets/schedule_task_list_item.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({Key? key, required this.tasks}) : super(key: key);

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (_, index) {
        return TaskListItem(
          task: tasks[index],
        );
      },
    );
  }
}
