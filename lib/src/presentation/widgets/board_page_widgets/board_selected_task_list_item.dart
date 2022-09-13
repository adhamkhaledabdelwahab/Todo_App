import 'package:flutter/material.dart';

import 'package:todo_app/src/core/constants/task_model_const.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:like_button/like_button.dart';
import 'package:todo_app/src/presentation/bloc/board_bloc/board_bloc.dart';

class SelectedTaskListItem extends StatelessWidget {
  const SelectedTaskListItem({
    Key? key,
    required this.task,
    required this.updateSelectedTasks,
    required this.isSelected,
  }) : super(key: key);

  final TaskModel task;
  final UpdateSelectedTasks updateSelectedTasks;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.delete,
            color: Colors.red,
            size: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          LikeButton(
            likeBuilder: (isLiked) {
              return Icon(
                isLiked ? Icons.favorite_outlined : Icons.favorite_outline,
                color: taskColors[task.color]!,
                size: 30,
              );
            },
            isLiked: task.isFavourite == 1,
            size: 30,
          ),
        ],
      ),
      title: Text(
        task.title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
      contentPadding:
          const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
      onTap: () {
        switch (updateSelectedTasks) {
          case UpdateSelectedTasks.allTasks:
            bool isExist =
                BoardBloc.get(context).selectedTasksAll.contains(task);
            BoardBloc.get(context).add(
              BoardUpdateSelectedTasks(
                task: task,
                updateSelectedTasks: updateSelectedTasks,
                isAdding: isExist == false,
              ),
            );
            break;
          case UpdateSelectedTasks.completedTasks:
            bool isExist =
                BoardBloc.get(context).selectedTasksCompleted.contains(task);
            BoardBloc.get(context).add(
              BoardUpdateSelectedTasks(
                task: task,
                updateSelectedTasks: updateSelectedTasks,
                isAdding: isExist == false,
              ),
            );
            break;
          case UpdateSelectedTasks.unCompletedTasks:
            bool isExist =
                BoardBloc.get(context).selectedTasksUnCompleted.contains(task);
            BoardBloc.get(context).add(
              BoardUpdateSelectedTasks(
                task: task,
                updateSelectedTasks: updateSelectedTasks,
                isAdding: isExist == false,
              ),
            );
            break;
          case UpdateSelectedTasks.favouriteTasks:
            bool isExist =
                BoardBloc.get(context).selectedTasksFavourite.contains(task);
            BoardBloc.get(context).add(
              BoardUpdateSelectedTasks(
                task: task,
                updateSelectedTasks: updateSelectedTasks,
                isAdding: isExist == false,
              ),
            );
            break;
        }
      },
      leading: isSelected
          ? const Icon(
              Icons.check,
              size: 20,
              color: Colors.white,
            )
          : null,
    );
  }
}
