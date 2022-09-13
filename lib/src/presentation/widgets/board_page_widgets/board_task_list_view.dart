import 'package:flutter/material.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/presentation/bloc/board_bloc/board_bloc.dart';
import 'package:todo_app/src/presentation/widgets/board_page_widgets/board_selected_task_list_item.dart';
import 'package:todo_app/src/presentation/widgets/board_page_widgets/widgets.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({
    Key? key,
    required this.tasks,
    required this.isLoading,
    required this.selectedTasks,
    required this.updateSelectedTasks,
  }) : super(key: key);

  final List<TaskModel> tasks;
  final List<TaskModel> selectedTasks;
  final bool isLoading;
  final UpdateSelectedTasks updateSelectedTasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: isLoading == true ? tasks.length + 1 : tasks.length,
      itemBuilder: (_, index) {
        if (isLoading == true && index == tasks.length) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return selectedTasks.isEmpty
            ? TaskListItem(
                task: tasks[index],
                updateSelectedTasks: updateSelectedTasks,
              )
            : SelectedTaskListItem(
                task: tasks[index],
                isSelected: selectedTasks.contains(
                  tasks[index],
                ),
                updateSelectedTasks: updateSelectedTasks,
              );
      },
    );
  }
}
