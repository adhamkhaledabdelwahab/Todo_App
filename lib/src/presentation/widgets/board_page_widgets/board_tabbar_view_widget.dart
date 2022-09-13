import 'package:flutter/material.dart';
import 'package:todo_app/src/core/components/empty_list_view.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/presentation/bloc/board_bloc/board_bloc.dart';
import 'package:todo_app/src/presentation/widgets/board_page_widgets/board_task_list_view.dart';

class BoardTabBarViewWidget extends StatelessWidget {
  const BoardTabBarViewWidget({
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
    return tasks.isNotEmpty
        ? TaskListView(
            tasks: tasks,
            isLoading: isLoading,
            selectedTasks: selectedTasks,
            updateSelectedTasks: updateSelectedTasks,
          )
        : const EmptyListView();
  }
}
