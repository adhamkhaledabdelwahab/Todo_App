import 'package:todo_app/src/core/database/database.dart';
import 'package:todo_app/src/core/errors/exceptions.dart';
import 'package:todo_app/src/data/data_sources/database_data_source.dart';
import 'package:todo_app/src/data/models/notification_model.dart';
import 'package:todo_app/src/data/models/task_model.dart';

class TaskDatabaseDataSourceImpl implements TaskDatabaseDataSource {
  @override
  DatabaseService databaseService;

  TaskDatabaseDataSourceImpl({
    required this.databaseService,
  });

  @override
  Future<void> initDB() async {
    try {
      await databaseService.initDatabaseProvider();
    } on DatabaseFetchingPathException {
      throw DatabaseFetchingPathException();
    } on DatabaseCreatingTaskTableException {
      throw DatabaseCreatingTaskTableException();
    } on DatabaseCreatingNotificationTableException {
      throw DatabaseCreatingNotificationTableException();
    } catch (e) {
      throw DatabaseInitializationException();
    }
  }

  @override
  Future<void> createNotification(
      {required NotificationModel notificationModel}) async {
    try {
      int id = await databaseService.createNotification(
        notificationModel: notificationModel,
      );
      if (id <= 0) {
        throw DatabaseCreateNotificationException();
      }
    } catch (e) {
      throw DatabaseCreateNotificationException();
    }
  }

  @override
  Future<void> createTask({required TaskModel taskModel}) async {
    try {
      int id = await databaseService.createTask(
        taskModel: taskModel,
      );
      if (id <= 0) {
        throw DatabaseCreateTaskException();
      }
    } catch (e) {
      throw DatabaseCreateTaskException();
    }
  }

  @override
  Future<void> deleteAllTasks() async {
    try {
      await databaseService.deleteAllTasks();
    } catch (e) {
      throw DatabaseDeleteAllTasksException();
    }
  }

  @override
  Future<void> deleteSelectedTasks({required List<TaskModel> tasks}) async {
    try {
      int count = await databaseService.deleteSelectedTasks(
        tasks: tasks,
      );
      if (count != tasks.length) {
        throw DatabaseDeleteSelectedTasksException();
      }
    } catch (e) {
      throw DatabaseDeleteSelectedTasksException();
    }
  }

  @override
  Future<void> deleteAllNotifications() async {
    try {
      await databaseService.deleteAllNotifications();
    } catch (e) {
      throw DatabaseDeleteAllNotificationsException();
    }
  }

  @override
  Future<void> deleteSelectedTasksNotifications(
      {required List<TaskModel> tasks}) async {
    try {
      await databaseService.deleteSelectedNotifications(
        tasks: tasks,
      );
    } catch (e) {
      throw DatabaseDeleteSelectedNotificationsException();
    }
  }

  @override
  Future<void> deleteSingleNotification(
      {required NotificationModel notification}) async {
    try {
      int count = await databaseService.deleteSingleNotification(
        notification: notification,
      );
      if (count != 1) {
        throw DatabaseDeleteSingleNotificationException();
      }
    } catch (e) {
      throw DatabaseDeleteSingleNotificationException();
    }
  }

  @override
  Future<void> deleteSingleTask({required TaskModel task}) async {
    try {
      int count = await databaseService.deleteSingleTask(
        task: task,
      );
      if (count != 1) {
        throw DatabaseDeleteSingleTaskException();
      }
    } catch (e) {
      throw DatabaseDeleteSingleTaskException();
    }
  }

  @override
  Future<void> deleteSingleTaskNotifications({required TaskModel task}) async {
    try {
      await databaseService.deleteSingleTaskNotifications(
        task: task,
      );
    } catch (e) {
      throw DatabaseDeletingSingleTaskNotificationsException();
    }
  }

  @override
  Future<List<NotificationModel>> fetchAllNotifications(
      {required DatabaseFetchParams databaseFetchParams}) async {
    try {
      List<Map<String, dynamic>> data =
          await databaseService.fetchAllNotifications(
        databaseFetchParams: databaseFetchParams,
      );
      return NotificationModel.fromJsonList(
        data,
      );
    } catch (e) {
      throw DatabaseFetchAllNotificationsException();
    }
  }

  @override
  Future<List<TaskModel>> fetchAllTasks(
      {required DatabaseFetchParams databaseFetchParams}) async {
    try {
      List<Map<String, dynamic>> data = await databaseService.fetchAllTasks(
        databaseFetchParams: databaseFetchParams,
      );
      return TaskModel.fromJsonList(
        data,
      );
    } catch (e) {
      throw DatabaseFetchAllTasksException();
    }
  }

  @override
  Future<List<TaskModel>> fetchCompletedTasks(
      {required DatabaseFetchParams databaseFetchParams}) async {
    try {
      List<Map<String, dynamic>> data =
          await databaseService.fetchCompletedTasks(
        databaseFetchParams: databaseFetchParams,
      );
      return TaskModel.fromJsonList(
        data,
      );
    } catch (e) {
      throw DatabaseFetchCompletedTasksException();
    }
  }

  @override
  Future<List<TaskModel>> fetchFavouriteTasks(
      {required DatabaseFetchParams databaseFetchParams}) async {
    try {
      List<Map<String, dynamic>> data =
          await databaseService.fetchFavouriteTasks(
        databaseFetchParams: databaseFetchParams,
      );
      return TaskModel.fromJsonList(
        data,
      );
    } catch (e) {
      throw DatabaseFetchFavouriteTasksException();
    }
  }

  @override
  Future<List<TaskModel>> fetchSelectedTasks(
      {required List<TaskModel> tasks}) async {
    try {
      List<Map<String, dynamic>> data =
          await databaseService.fetchSelectedTasks(
        tasks: tasks,
      );
      if (data.length != tasks.length) {
        throw DatabaseFetchSelectedTasksException();
      }
      return TaskModel.fromJsonList(
        data,
      );
    } catch (e) {
      throw DatabaseFetchSelectedTasksException();
    }
  }

  @override
  Future<TaskModel> fetchSingleTask({TaskModel? task, int? id}) async {
    try {
      List<Map<String, dynamic>> data =
          await databaseService.fetchSingleTask(task: task, id: id);
      if (data.length != 1) {
        throw DatabaseFetchSingleTaskException();
      }
      return TaskModel.fromJson(
        data[0],
      );
    } catch (e) {
      throw DatabaseFetchSingleTaskException();
    }
  }

  @override
  Future<NotificationModel> fetchSingleNotification(
      {required NotificationModel notification}) async {
    try {
      List<Map<String, dynamic>> data =
          await databaseService.fetchSingleNotification(
        notification: notification,
      );
      if (data.length != 1) {
        throw DatabaseFetchSingleNotificationException();
      }
      return NotificationModel.fromJson(
        data[0],
      );
    } catch (e) {
      throw DatabaseFetchSingleNotificationException();
    }
  }

  @override
  Future<List<TaskModel>> fetchUnCompletedTasks(
      {required DatabaseFetchParams databaseFetchParams}) async {
    try {
      List<Map<String, dynamic>> data =
          await databaseService.fetchUnCompletedTasks(
        databaseFetchParams: databaseFetchParams,
      );
      return TaskModel.fromJsonList(
        data,
      );
    } catch (e) {
      throw DatabaseFetchUnCompletedTasksException();
    }
  }

  @override
  Future<void> markAllNotificationsAsRead() async {
    try {
      await databaseService.markAllNotificationsAsRead();
    } catch (e) {
      throw DatabaseMarkAllNotificationAsReadException();
    }
  }

  @override
  Future<void> markAllTasksAsCompleted() async {
    try {
      await databaseService.markAllTasksAsCompleted();
    } catch (e) {
      throw DatabaseMarkAllTasksAsCompletedException();
    }
  }

  @override
  Future<void> markAllTasksAsFavourite() async {
    try {
      await databaseService.markAllTasksAsFavourite();
    } catch (e) {
      throw DatabaseMarkAllTasksAsFavouriteException();
    }
  }

  @override
  Future<void> markAllTasksAsUnCompleted() async {
    try {
      await databaseService.markAllTasksAsUnCompleted();
    } catch (e) {
      throw DatabaseMarkAllTasksAsUnCompletedException();
    }
  }

  @override
  Future<void> markAllTasksAsUnFavourite() async {
    try {
      await databaseService.markAllTasksAsUnFavourite();
    } catch (e) {
      throw DatabaseMarkAllTasksAsUnFavouriteException();
    }
  }

  @override
  Future<void> markSelectedTasksAsCompleted(
      {required List<TaskModel> tasks}) async {
    try {
      int count =
          await databaseService.markSelectedTasksAsCompleted(tasks: tasks);
      if (count != tasks.length) {
        throw DatabaseMarkSelectedTasksAsCompletedException();
      }
    } catch (e) {
      throw DatabaseMarkSelectedTasksAsCompletedException();
    }
  }

  @override
  Future<void> markSelectedTasksAsFavourite(
      {required List<TaskModel> tasks}) async {
    try {
      int count =
          await databaseService.markSelectedTasksAsFavourite(tasks: tasks);
      if (count != tasks.length) {
        throw DatabaseMarkSelectedTasksAsFavouriteException();
      }
    } catch (e) {
      throw DatabaseMarkSelectedTasksAsFavouriteException();
    }
  }

  @override
  Future<void> markSelectedTasksAsUnCompleted(
      {required List<TaskModel> tasks}) async {
    try {
      int count =
          await databaseService.markSelectedTasksAsUnCompleted(tasks: tasks);
      if (count != tasks.length) {
        throw DatabaseMarkSelectedTasksAsUnCompletedException();
      }
    } catch (e) {
      throw DatabaseMarkSelectedTasksAsUnCompletedException();
    }
  }

  @override
  Future<void> markSelectedTasksAsUnFavourite(
      {required List<TaskModel> tasks}) async {
    try {
      int count =
          await databaseService.markSelectedTasksAsUnFavourite(tasks: tasks);
      if (count != tasks.length) {
        throw DatabaseMarkSelectedTasksAsUnFavouriteException();
      }
    } catch (e) {
      throw DatabaseMarkSelectedTasksAsUnFavouriteException();
    }
  }

  @override
  Future<void> markSingleNotificationAsRead({
    NotificationModel? notification,
    String? notifiedAt,
    String? taskUniqueName,
  }) async {
    try {
      int count = await databaseService.markSingleNotificationAsRead(
        notification: notification,
        notifiedAt: notifiedAt,
        taskUniqueName: taskUniqueName,
      );
      if (count != 1) {
        throw DatabaseMarkSingleNotificationAsReadException();
      }
    } catch (e) {
      throw DatabaseMarkSingleNotificationAsReadException();
    }
  }

  @override
  Future<void> markSingleNotificationAsUnRead(
      {required NotificationModel notification}) async {
    try {
      int count = await databaseService.markSingleNotificationAsUnRead(
          notification: notification);
      if (count != 1) {
        throw DatabaseMarkSingleNotificationAsUnReadException();
      }
    } catch (e) {
      throw DatabaseMarkSingleNotificationAsUnReadException();
    }
  }

  @override
  Future<void> markSingleTaskAsCompleted({required TaskModel task}) async {
    try {
      int count = await databaseService.markSingleTaskAsCompleted(task: task);
      if (count != 1) {
        throw DatabaseMarkSingleTaskAsCompletedException();
      }
    } catch (e) {
      throw DatabaseMarkSingleTaskAsCompletedException();
    }
  }

  @override
  Future<void> markSingleTaskAsFavourite({required TaskModel task}) async {
    try {
      int count = await databaseService.markSingleTaskAsFavourite(task: task);
      if (count != 1) {
        throw DatabaseMarkSingleTaskAsFavouriteException();
      }
    } catch (e) {
      throw DatabaseMarkSingleTaskAsFavouriteException();
    }
  }

  @override
  Future<void> markSingleTaskAsUnCompleted({required TaskModel task}) async {
    try {
      int count = await databaseService.markSingleTaskAsUnCompleted(task: task);
      if (count != 1) {
        throw DatabaseMarkSingleTaskAsUnCompletedException();
      }
    } catch (e) {
      throw DatabaseMarkSingleTaskAsUnCompletedException();
    }
  }

  @override
  Future<void> markSingleTaskAsUnFavourite({required TaskModel task}) async {
    try {
      int count = await databaseService.markSingleTaskAsUnFavourite(task: task);
      if (count != 1) {
        throw DatabaseMarkSingleTaskAsUnFavouriteException();
      }
    } catch (e) {
      throw DatabaseMarkSingleTaskAsUnFavouriteException();
    }
  }
}
