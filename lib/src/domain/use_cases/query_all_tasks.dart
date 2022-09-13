import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/core/errors/failures.dart';
import 'package:todo_app/src/core/use_cases/use_cases.dart';
import 'package:todo_app/src/domain/repository/task_repository.dart';

enum QueryAllTasks {
  deleteAllTasks,
  markAllTasksAsCompleted,
  markAllTasksAsUnCompleted,
  markAllTasksAsFavourite,
  markAllTasksAsUnFavourite,
}

class GetQueryAllTasks extends UseCase<Failures, void, QueryAllTasksParams> {
  final TaskRepository taskRepository;

  GetQueryAllTasks({required this.taskRepository});

  @override
  Future<Either<Failures, void>> call(QueryAllTasksParams params) async {
    switch (params.queryAllTasks) {
      case QueryAllTasks.deleteAllTasks:
        return await taskRepository.deleteAllTasks();
      case QueryAllTasks.markAllTasksAsCompleted:
        return await taskRepository.markAllTasksAsCompleted();
      case QueryAllTasks.markAllTasksAsUnCompleted:
        return await taskRepository.markAllTasksAsUnCompleted();
      case QueryAllTasks.markAllTasksAsFavourite:
        return await taskRepository.markAllTasksAsFavourite();
      case QueryAllTasks.markAllTasksAsUnFavourite:
        return await taskRepository.markAllTasksAsUnFavourite();
    }
  }
}

class QueryAllTasksParams extends Equatable {
  final QueryAllTasks queryAllTasks;

  const QueryAllTasksParams({required this.queryAllTasks});

  @override
  List<Object?> get props => [
        queryAllTasks,
      ];
}
