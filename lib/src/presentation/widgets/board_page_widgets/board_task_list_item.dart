import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo_app/src/core/constants/task_model_const.dart';
import 'package:todo_app/src/core/routes/routes.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:like_button/like_button.dart';
import 'package:todo_app/src/presentation/bloc/board_bloc/board_bloc.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    Key? key,
    required this.task,
    required this.updateSelectedTasks,
  }) : super(key: key);

  final TaskModel task;
  final UpdateSelectedTasks updateSelectedTasks;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => BoardBloc.get(context).add(
              BoardDeleteSingleTask(task: task),
            ),
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          LikeButton(
            onTap: (isFav) {
              if (task.isFavourite == 0) {
                BoardBloc.get(context).add(
                  BoardMarkSingleTaskAsFavourite(
                    task: task,
                  ),
                );
              } else {
                BoardBloc.get(context).add(
                  BoardMarkSingleTaskAsUnFavourite(
                    task: task,
                  ),
                );
              }
              return Future.value(true);
            },
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
      onTap: () => Get.toNamed(
        taskScreenRoute,
        arguments: task,
      ),
      leading: SizedBox(
        width: 40,
        child: LikeButton(
          onTap: (isFav) {
            if (task.isCompleted == 0) {
              BoardBloc.get(context).add(
                BoardMarkSingleTaskAsCompleted(
                  task: task,
                ),
              );
            } else {
              BoardBloc.get(context).add(
                BoardMarkSingleTaskAsUnCompleted(
                  task: task,
                ),
              );
            }
            return Future.value(true);
          },
          likeBuilder: (isLiked) {
            return Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: taskColors[task.color]!,
                ),
                color: isLiked ? taskColors[task.color] : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: isLiked
                  ? const Icon(
                      Icons.check,
                      size: 20,
                      color: Colors.white,
                    )
                  : null,
            );
          },
          isLiked: task.isCompleted == 1,
          size: 30,
        ),
      ),
    );
  }
}
