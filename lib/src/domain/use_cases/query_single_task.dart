import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/core/errors/failures.dart';
import 'package:todo_app/src/core/use_cases/use_cases.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/domain/repository/task_repository.dart';

enum QuerySingleTask {
  createTask,
  markSingleTaskAsCompleted,
  markSingleTaskAsUnCompleted,
  markSingleTaskAsFavourite,
  markSingleTaskAsUnFavourite,
  deleteSingleTask,
}

class GetQuerySingleTask extends UseCase<Either<Failures, TaskModel>,
    Either<Failures, void>, QuerySingleTaskParams> {
  final TaskRepository taskRepository;

  GetQuerySingleTask({required this.taskRepository});

  @override
  Future<Either<Either<Failures, TaskModel>, Either<Failures, void>>> call(
      QuerySingleTaskParams params) async {
    switch (params.querySingleTask) {
      case QuerySingleTask.createTask:
        return Left(
          await taskRepository.createTask(
            taskModel: params.task,
          ),
        );
      case QuerySingleTask.deleteSingleTask:
        return Right(
          await taskRepository.deleteSingleTask(
            taskModel: params.task,
          ),
        );
      case QuerySingleTask.markSingleTaskAsCompleted:
        return Left(
          await taskRepository.markSingleTaskAsCompleted(
            task: params.task,
          ),
        );
      case QuerySingleTask.markSingleTaskAsUnCompleted:
        return Left(
          await taskRepository.markSingleTaskAsUnCompleted(
            task: params.task,
          ),
        );
      case QuerySingleTask.markSingleTaskAsFavourite:
        return Left(
          await taskRepository.markSingleTaskAsFavourite(
            task: params.task,
          ),
        );
      case QuerySingleTask.markSingleTaskAsUnFavourite:
        return Left(
          await taskRepository.markSingleTaskAsUnFavourite(
            task: params.task,
          ),
        );
    }
  }
}

class QuerySingleTaskParams extends Equatable {
  final QuerySingleTask querySingleTask;
  final TaskModel task;

  const QuerySingleTaskParams({
    required this.querySingleTask,
    required this.task,
  });

  @override
  List<Object?> get props => [
        querySingleTask,
        task,
      ];
}
