import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/core/errors/failures.dart';
import 'package:todo_app/src/core/use_cases/use_cases.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/domain/repository/task_repository.dart';

enum QuerySelectedTasks {
  deleteSelectedTasks,
  markSelectedTasksAsCompleted,
  markSelectedTasksAsUnCompleted,
  markSelectedTasksAsFavourite,
  markSelectedTasksAsUnFavourite,
}

class GetQuerySelectedTasks extends UseCase<Either<Failures, List<TaskModel>>,
    Either<Failures, void>, QuerySelectedTasksParams> {
  final TaskRepository taskRepository;

  GetQuerySelectedTasks({required this.taskRepository});

  @override
  Future<Either<Either<Failures, List<TaskModel>>, Either<Failures, void>>>
      call(QuerySelectedTasksParams params) async {
    switch (params.querySelectedTasks) {
      case QuerySelectedTasks.deleteSelectedTasks:
        return Right(
          await taskRepository.deleteSelectedTasks(
            tasks: params.tasks,
          ),
        );
      case QuerySelectedTasks.markSelectedTasksAsCompleted:
        return Left(
          await taskRepository.markSelectedTasksAsCompleted(
            tasks: params.tasks,
          ),
        );
      case QuerySelectedTasks.markSelectedTasksAsUnCompleted:
        return Left(
          await taskRepository.markSelectedTasksAsUnCompleted(
            tasks: params.tasks,
          ),
        );
      case QuerySelectedTasks.markSelectedTasksAsFavourite:
        return Left(
          await taskRepository.markSelectedTasksAsFavourite(
            tasks: params.tasks,
          ),
        );
      case QuerySelectedTasks.markSelectedTasksAsUnFavourite:
        return Left(
          await taskRepository.markSelectedTasksAsUnFavourite(
            tasks: params.tasks,
          ),
        );
    }
  }
}

class QuerySelectedTasksParams extends Equatable {
  final QuerySelectedTasks querySelectedTasks;
  final List<TaskModel> tasks;

  const QuerySelectedTasksParams({
    required this.querySelectedTasks,
    required this.tasks,
  });

  @override
  List<Object?> get props => [
        querySelectedTasks,
        tasks,
      ];
}
