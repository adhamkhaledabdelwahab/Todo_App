import 'package:todo_app/src/core/database/database.dart';
import 'package:todo_app/src/data/models/notification_model.dart';
import 'package:todo_app/src/data/models/task_model.dart';

abstract class TaskDatabaseDataSource {
  late DatabaseService databaseService;

  Future<void> initDB();

  Future<void> createTask({
    required TaskModel taskModel,
  });

  Future<void> createNotification({
    required NotificationModel notificationModel,
  });

  Future<void> deleteAllTasks();

  Future<void> deleteSelectedTasks({
    required List<TaskModel> tasks,
  });

  Future<void> deleteAllNotifications();

  Future<void> deleteSelectedTasksNotifications({
    required List<TaskModel> tasks,
  });

  Future<void> deleteSingleTask({
    required TaskModel task,
  });

  Future<void> deleteSingleTaskNotifications({
    required TaskModel task,
  });

  Future<void> deleteSingleNotification({
    required NotificationModel notification,
  });

  Future<List<TaskModel>> fetchAllTasks({
    required DatabaseFetchParams databaseFetchParams,
  });

  Future<List<TaskModel>> fetchCompletedTasks({
    required DatabaseFetchParams databaseFetchParams,
  });

  Future<List<TaskModel>> fetchUnCompletedTasks({
    required DatabaseFetchParams databaseFetchParams,
  });

  Future<List<TaskModel>> fetchFavouriteTasks({
    required DatabaseFetchParams databaseFetchParams,
  });

  Future<List<TaskModel>> fetchSelectedTasks({
    required List<TaskModel> tasks,
  });

  Future<TaskModel> fetchSingleTask({
    TaskModel? task,
    int? id,
  });

  Future<NotificationModel> fetchSingleNotification({
    required NotificationModel notification,
  });

  Future<List<NotificationModel>> fetchAllNotifications({
    required DatabaseFetchParams databaseFetchParams,
  });

  Future<void> markAllTasksAsFavourite();

  Future<void> markAllTasksAsUnFavourite();

  Future<void> markAllTasksAsCompleted();

  Future<void> markAllTasksAsUnCompleted();

  Future<void> markSelectedTasksAsFavourite({
    required List<TaskModel> tasks,
  });

  Future<void> markSelectedTasksAsUnFavourite({
    required List<TaskModel> tasks,
  });

  Future<void> markSelectedTasksAsCompleted({
    required List<TaskModel> tasks,
  });

  Future<void> markSelectedTasksAsUnCompleted({
    required List<TaskModel> tasks,
  });

  Future<void> markSingleTaskAsFavourite({
    required TaskModel task,
  });

  Future<void> markSingleTaskAsUnFavourite({
    required TaskModel task,
  });

  Future<void> markSingleTaskAsCompleted({
    required TaskModel task,
  });

  Future<void> markSingleTaskAsUnCompleted({
    required TaskModel task,
  });

  Future<void> markAllNotificationsAsRead();

  Future<void> markSingleNotificationAsRead({
    NotificationModel? notification,
    String? notifiedAt,
    String? taskUniqueName,
  });

  Future<void> markSingleNotificationAsUnRead({
    required NotificationModel notification,
  });
}
