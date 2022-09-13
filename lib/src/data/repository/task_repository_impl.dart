import 'package:dartz/dartz.dart';
import 'package:todo_app/src/core/database/database_fetch_params.dart';
import 'package:todo_app/src/core/errors/exceptions.dart';
import 'package:todo_app/src/core/errors/failures.dart';
import 'package:todo_app/src/data/data_sources/data_sources.dart';
import 'package:todo_app/src/data/models/notification_model.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  @override
  TaskDatabaseDataSource taskDatabaseDataSource;

  @override
  TaskNotificationDataSource taskNotificationDataSource;

  TaskRepositoryImpl({
    required this.taskDatabaseDataSource,
    required this.taskNotificationDataSource,
  });

  @override
  Future<Either<Failures, void>> initAppServices() async {
    try {
      await taskDatabaseDataSource.initDB();
      await taskNotificationDataSource.initNotificationService();
      void result;
      return Right(result);
    } on DatabaseFetchingPathException {
      return const Left(DatabaseFetchingPathFailure());
    } on DatabaseCreatingTaskTableException {
      return const Left(DatabaseCreatingTaskTableFailure());
    } on DatabaseCreatingNotificationTableException {
      return const Left(DatabaseCreatingNotificationTableFailure());
    } on DatabaseInitializationException {
      return const Left(DatabaseInitializationFailure());
    } on NotificationInitTimeZonesException {
      return const Left(NotificationInitTimeZonesFailure());
    } on NotificationIOSPermissionException {
      return const Left(NotificationIOSPermissionFailure());
    } on NotificationInitializationException {
      return const Left(NotificationInitializationFailure());
    } on NotificationWorkManagerInitializationException {
      return const Left(NotificationWorkManagerInitializationFailure());
    }
  }

  @override
  Future<Either<Failures, TaskModel>> createTask({
    required TaskModel taskModel,
  }) async {
    try {
      await taskDatabaseDataSource.createTask(
        taskModel: taskModel,
      );
      TaskModel result = await taskDatabaseDataSource.fetchSingleTask(
        task: taskModel,
      );
      result.repeat == 0
          ? await taskNotificationDataSource.scheduleNotification(result)
          : await taskNotificationDataSource.repeatNotification(result);
      return Right(result);
    } on NotificationScheduleException {
      return const Left(NotificationScheduleFailure());
    } on NotificationRepeatException {
      return const Left(NotificationRepeatFailure());
    } on DatabaseCreateTaskException {
      return const Left(DatabaseCreateTaskFailure());
    } on DatabaseFetchSingleTaskException {
      return const Left(DatabaseFetchSingleTaskFailure());
    }
  }

  @override
  Future<Either<Failures, void>> deleteAllTasks() async {
    try {
      await taskDatabaseDataSource.deleteAllNotifications();
      await taskDatabaseDataSource.deleteAllTasks();
      return Right(
        await taskNotificationDataSource.cancelAllNotifications(),
      );
    } on DatabaseDeleteAllNotificationsException {
      return const Left(DatabaseDeleteAllNotificationsFailure());
    } on DatabaseDeleteAllTasksException {
      return const Left(DatabaseDeleteAllTasksFailure());
    } on NotificationCancelALlException {
      return const Left(NotificationCancelALlFailure());
    }
  }

  @override
  Future<Either<Failures, void>> deleteSingleTask({
    required TaskModel taskModel,
  }) async {
    try {
      await taskNotificationDataSource.cancelSingleNotification(
        taskModel,
      );
      await taskDatabaseDataSource.deleteSingleTaskNotifications(
          task: taskModel);
      return Right(
        await taskDatabaseDataSource.deleteSingleTask(
          task: taskModel,
        ),
      );
    } on DatabaseDeletingSingleTaskNotificationsException {
      return const Left(DatabaseDeletingSingleTaskNotificationsFailure());
    } on DatabaseDeleteSingleTaskException {
      return const Left(DatabaseDeleteSingleTaskFailure());
    } on NotificationCancelSingleException {
      return const Left(NotificationCancelSingleFailure());
    }
  }

  @override
  Future<Either<Failures, List<TaskModel>>> fetchAllTasks({
    required DatabaseFetchParams databaseFetchParams,
  }) async {
    try {
      return Right(await taskDatabaseDataSource.fetchAllTasks(
        databaseFetchParams: databaseFetchParams,
      ));
    } on DatabaseFetchAllTasksException {
      return const Left(DatabaseFetchAllTasksFailure());
    }
  }

  @override
  Future<Either<Failures, void>> deleteSelectedTasks(
      {required List<TaskModel> tasks}) async {
    try {
      await taskNotificationDataSource.cancelSelectedNotifications(
        tasks,
      );
      await taskDatabaseDataSource.deleteSelectedTasksNotifications(
          tasks: tasks);
      return Right(
        await taskDatabaseDataSource.deleteSelectedTasks(
          tasks: tasks,
        ),
      );
    } on DatabaseDeleteSelectedNotificationsException {
      return const Left(DatabaseDeleteSelectedNotificationsFailure());
    } on DatabaseDeleteSelectedTasksException {
      return const Left(DatabaseDeleteSelectedTasksFailure());
    } on NotificationCancelSelectedException {
      return const Left(NotificationCancelSelectedFailure());
    }
  }

  @override
  Future<Either<Failures, void>> deleteSingleNotification(
      {required NotificationModel notification}) async {
    try {
      return Right(
        await taskDatabaseDataSource.deleteSingleNotification(
          notification: notification,
        ),
      );
    } on DatabaseDeleteSingleNotificationException {
      return const Left(DatabaseDeleteSingleNotificationFailure());
    }
  }

  @override
  Future<Either<Failures, List<NotificationModel>>> fetchAllNotifications(
      {required DatabaseFetchParams databaseFetchParams}) async {
    try {
      return Right(
        await taskDatabaseDataSource.fetchAllNotifications(
          databaseFetchParams: databaseFetchParams,
        ),
      );
    } on DatabaseFetchAllNotificationsException {
      return const Left(DatabaseFetchAllNotificationsFailure());
    }
  }

  @override
  Future<Either<Failures, List<TaskModel>>> fetchCompletedTasks(
      {required DatabaseFetchParams databaseFetchParams}) async {
    try {
      return Right(
        await taskDatabaseDataSource.fetchCompletedTasks(
          databaseFetchParams: databaseFetchParams,
        ),
      );
    } catch (e) {
      return const Left(DatabaseFetchCompletedTasksFailure());
    }
  }

  @override
  Future<Either<Failures, List<TaskModel>>> fetchFavouriteTasks(
      {required DatabaseFetchParams databaseFetchParams}) async {
    try {
      return Right(
        await taskDatabaseDataSource.fetchFavouriteTasks(
          databaseFetchParams: databaseFetchParams,
        ),
      );
    } catch (e) {
      return const Left(DatabaseFetchFavouriteTasksFailure());
    }
  }

  @override
  Future<Either<Failures, List<TaskModel>>> fetchUnCompletedTasks(
      {required DatabaseFetchParams databaseFetchParams}) async {
    try {
      return Right(
        await taskDatabaseDataSource.fetchUnCompletedTasks(
          databaseFetchParams: databaseFetchParams,
        ),
      );
    } catch (e) {
      return const Left(DatabaseFetchUnCompletedTasksFailure());
    }
  }

  @override
  Future<Either<Failures, void>> markAllNotificationsAsRead() async {
    try {
      return Right(
        await taskDatabaseDataSource.markAllNotificationsAsRead(),
      );
    } catch (e) {
      return const Left(DatabaseMarkAllNotificationAsReadFailure());
    }
  }

  @override
  Future<Either<Failures, void>> markAllTasksAsCompleted() async {
    try {
      return Right(await taskDatabaseDataSource.markAllTasksAsCompleted());
    } catch (e) {
      return const Left(DatabaseMarkAllTasksAsCompletedFailure());
    }
  }

  @override
  Future<Either<Failures, void>> markAllTasksAsFavourite() async {
    try {
      return Right(await taskDatabaseDataSource.markAllTasksAsFavourite());
    } catch (e) {
      return const Left(DatabaseMarkAllTasksAsFavouriteFailure());
    }
  }

  @override
  Future<Either<Failures, void>> markAllTasksAsUnCompleted() async {
    try {
      return Right(await taskDatabaseDataSource.markAllTasksAsUnCompleted());
    } catch (e) {
      return const Left(DatabaseMarkAllTasksAsUnCompletedFailure());
    }
  }

  @override
  Future<Either<Failures, void>> markAllTasksAsUnFavourite() async {
    try {
      return Right(await taskDatabaseDataSource.markAllTasksAsUnFavourite());
    } catch (e) {
      return const Left(DatabaseMarkAllTasksAsUnFavouriteFailure());
    }
  }

  @override
  Future<Either<Failures, List<TaskModel>>> markSelectedTasksAsCompleted(
      {required List<TaskModel> tasks}) async {
    try {
      await taskDatabaseDataSource.markSelectedTasksAsCompleted(
        tasks: tasks,
      );
      return Right(
        await taskDatabaseDataSource.fetchSelectedTasks(
          tasks: tasks,
        ),
      );
    } on DatabaseFetchSelectedTasksException {
      return const Left(DatabaseFetchSelectedTasksFailure());
    } catch (e) {
      return const Left(DatabaseMarkSelectedTasksAsCompletedFailure());
    }
  }

  @override
  Future<Either<Failures, List<TaskModel>>> markSelectedTasksAsFavourite(
      {required List<TaskModel> tasks}) async {
    try {
      await taskDatabaseDataSource.markSelectedTasksAsFavourite(tasks: tasks);
      return Right(
        await taskDatabaseDataSource.fetchSelectedTasks(
          tasks: tasks,
        ),
      );
    } on DatabaseFetchSelectedTasksException {
      return const Left(DatabaseFetchSelectedTasksFailure());
    } catch (e) {
      return const Left(DatabaseMarkSelectedTasksAsFavouriteFailure());
    }
  }

  @override
  Future<Either<Failures, List<TaskModel>>> markSelectedTasksAsUnCompleted(
      {required List<TaskModel> tasks}) async {
    try {
      await taskDatabaseDataSource.markSelectedTasksAsUnCompleted(tasks: tasks);
      return Right(
        await taskDatabaseDataSource.fetchSelectedTasks(
          tasks: tasks,
        ),
      );
    } on DatabaseFetchSelectedTasksException {
      return const Left(DatabaseFetchSelectedTasksFailure());
    } catch (e) {
      return const Left(DatabaseMarkSelectedTasksAsUnCompletedFailure());
    }
  }

  @override
  Future<Either<Failures, List<TaskModel>>> markSelectedTasksAsUnFavourite(
      {required List<TaskModel> tasks}) async {
    try {
      await taskDatabaseDataSource.markSelectedTasksAsUnFavourite(tasks: tasks);
      return Right(
        await taskDatabaseDataSource.fetchSelectedTasks(
          tasks: tasks,
        ),
      );
    } on DatabaseFetchSelectedTasksException {
      return const Left(DatabaseFetchSelectedTasksFailure());
    } catch (e) {
      return const Left(DatabaseMarkSelectedTasksAsUnFavouriteFailure());
    }
  }

  @override
  Future<Either<Failures, NotificationModel>> markSingleNotificationAsRead(
      {required NotificationModel notification}) async {
    try {
      await taskDatabaseDataSource.markSingleNotificationAsRead(
        notification: notification,
      );
      return Right(
        await taskDatabaseDataSource.fetchSingleNotification(
          notification: notification,
        ),
      );
    } on DatabaseFetchSingleNotificationException {
      return const Left(DatabaseFetchSingleNotificationFailure());
    } catch (e) {
      return const Left(DatabaseMarkSingleNotificationAsReadFailure());
    }
  }

  @override
  Future<Either<Failures, NotificationModel>> markSingleNotificationAsUnRead(
      {required NotificationModel notification}) async {
    try {
      await taskDatabaseDataSource.markSingleNotificationAsUnRead(
        notification: notification,
      );
      return Right(
        await taskDatabaseDataSource.fetchSingleNotification(
          notification: notification,
        ),
      );
    } on DatabaseFetchSingleNotificationException {
      return const Left(DatabaseFetchSingleNotificationFailure());
    } catch (e) {
      return const Left(DatabaseMarkSingleNotificationAsUnReadFailure());
    }
  }

  @override
  Future<Either<Failures, TaskModel>> markSingleTaskAsCompleted(
      {required TaskModel task}) async {
    try {
      await taskDatabaseDataSource.markSingleTaskAsCompleted(task: task);
      return Right(
        await taskDatabaseDataSource.fetchSingleTask(
          task: task,
        ),
      );
    } on DatabaseFetchSingleTaskException {
      return const Left(DatabaseFetchSingleTaskFailure());
    } catch (e) {
      return const Left(DatabaseMarkSingleTaskAsCompletedFailure());
    }
  }

  @override
  Future<Either<Failures, TaskModel>> markSingleTaskAsFavourite(
      {required TaskModel task}) async {
    try {
      await taskDatabaseDataSource.markSingleTaskAsFavourite(task: task);
      return Right(
        await taskDatabaseDataSource.fetchSingleTask(
          task: task,
        ),
      );
    } on DatabaseFetchSingleTaskException {
      return const Left(DatabaseFetchSingleTaskFailure());
    } catch (e) {
      return const Left(DatabaseMarkSingleTaskAsFavouriteFailure());
    }
  }

  @override
  Future<Either<Failures, TaskModel>> markSingleTaskAsUnCompleted(
      {required TaskModel task}) async {
    try {
      await taskDatabaseDataSource.markSingleTaskAsUnCompleted(task: task);
      return Right(
        await taskDatabaseDataSource.fetchSingleTask(
          task: task,
        ),
      );
    } on DatabaseFetchSingleTaskException {
      return const Left(DatabaseFetchSingleTaskFailure());
    } catch (e) {
      return const Left(DatabaseMarkSingleTaskAsUnCompletedFailure());
    }
  }

  @override
  Future<Either<Failures, TaskModel>> markSingleTaskAsUnFavourite(
      {required TaskModel task}) async {
    try {
      await taskDatabaseDataSource.markSingleTaskAsUnFavourite(task: task);
      return Right(
        await taskDatabaseDataSource.fetchSingleTask(
          task: task,
        ),
      );
    } on DatabaseFetchSingleTaskException {
      return const Left(DatabaseFetchSingleTaskFailure());
    } catch (e) {
      return const Left(DatabaseMarkSingleTaskAsUnFavouriteFailure());
    }
  }
}
