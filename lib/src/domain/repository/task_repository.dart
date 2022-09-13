import 'package:dartz/dartz.dart';
import 'package:todo_app/src/core/database/database_fetch_params.dart';
import 'package:todo_app/src/data/data_sources/data_sources.dart';
import 'package:todo_app/src/data/models/notification_model.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/core/errors/failures.dart';

abstract class TaskRepository {
  late TaskDatabaseDataSource taskDatabaseDataSource;
  late TaskNotificationDataSource taskNotificationDataSource;

  Future<Either<Failures, void>> initAppServices();

  Future<Either<Failures, TaskModel>> createTask({
    required TaskModel taskModel,
  });

  Future<Either<Failures, void>> deleteSingleTask({
    required TaskModel taskModel,
  });

  Future<Either<Failures, void>> deleteSingleNotification({
    required NotificationModel notification,
  });

  Future<Either<Failures, TaskModel>> markSingleTaskAsFavourite({
    required TaskModel task,
  });

  Future<Either<Failures, TaskModel>> markSingleTaskAsUnFavourite({
    required TaskModel task,
  });

  Future<Either<Failures, TaskModel>> markSingleTaskAsCompleted({
    required TaskModel task,
  });

  Future<Either<Failures, TaskModel>> markSingleTaskAsUnCompleted({
    required TaskModel task,
  });

  Future<Either<Failures, NotificationModel>> markSingleNotificationAsRead({
    required NotificationModel notification,
  });

  Future<Either<Failures, NotificationModel>> markSingleNotificationAsUnRead({
    required NotificationModel notification,
  });

  Future<Either<Failures, void>> deleteAllTasks();

  Future<Either<Failures, void>> markAllTasksAsFavourite();

  Future<Either<Failures, void>> markAllTasksAsUnFavourite();

  Future<Either<Failures, void>> markAllTasksAsCompleted();

  Future<Either<Failures, void>> markAllTasksAsUnCompleted();

  Future<Either<Failures, List<NotificationModel>>> fetchAllNotifications({
    required DatabaseFetchParams databaseFetchParams,
  });

  Future<Either<Failures, void>> markAllNotificationsAsRead();

  Future<Either<Failures, void>> deleteSelectedTasks({
    required List<TaskModel> tasks,
  });

  Future<Either<Failures, List<TaskModel>>> markSelectedTasksAsFavourite({
    required List<TaskModel> tasks,
  });

  Future<Either<Failures, List<TaskModel>>> markSelectedTasksAsUnFavourite({
    required List<TaskModel> tasks,
  });

  Future<Either<Failures, List<TaskModel>>> markSelectedTasksAsCompleted({
    required List<TaskModel> tasks,
  });

  Future<Either<Failures, List<TaskModel>>> markSelectedTasksAsUnCompleted({
    required List<TaskModel> tasks,
  });

  Future<Either<Failures, List<TaskModel>>> fetchAllTasks({
    required DatabaseFetchParams databaseFetchParams,
  });

  Future<Either<Failures, List<TaskModel>>> fetchCompletedTasks({
    required DatabaseFetchParams databaseFetchParams,
  });

  Future<Either<Failures, List<TaskModel>>> fetchUnCompletedTasks({
    required DatabaseFetchParams databaseFetchParams,
  });

  Future<Either<Failures, List<TaskModel>>> fetchFavouriteTasks({
    required DatabaseFetchParams databaseFetchParams,
  });
}
