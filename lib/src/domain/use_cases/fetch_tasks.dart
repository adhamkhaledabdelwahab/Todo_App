import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/core/database/database_fetch_params.dart';
import 'package:todo_app/src/core/errors/failures.dart';
import 'package:todo_app/src/core/use_cases/use_cases.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/domain/repository/task_repository.dart';

enum FetchTasks {
  all,
  completed,
  uncompleted,
  favourite,
}

class GetFetchTasks
    extends UseCase<Failures, List<TaskModel>, FetchTasksParams> {
  final TaskRepository taskRepository;

  GetFetchTasks({required this.taskRepository});

  @override
  Future<Either<Failures, List<TaskModel>>> call(
      FetchTasksParams params) async {
    switch (params.fetchTasks) {
      case FetchTasks.all:
        return await taskRepository.fetchAllTasks(
          databaseFetchParams: params.databaseFetchParams,
        );
      case FetchTasks.completed:
        return await taskRepository.fetchCompletedTasks(
          databaseFetchParams: params.databaseFetchParams,
        );
      case FetchTasks.uncompleted:
        return await taskRepository.fetchUnCompletedTasks(
          databaseFetchParams: params.databaseFetchParams,
        );
      case FetchTasks.favourite:
        return await taskRepository.fetchFavouriteTasks(
          databaseFetchParams: params.databaseFetchParams,
        );
    }
  }
}

class FetchTasksParams extends Equatable {
  final FetchTasks fetchTasks;
  final DatabaseFetchParams databaseFetchParams;

  const FetchTasksParams({
    required this.fetchTasks,
    required this.databaseFetchParams,
  });

  @override
  List<Object?> get props => [
        fetchTasks,
        databaseFetchParams,
      ];
}
