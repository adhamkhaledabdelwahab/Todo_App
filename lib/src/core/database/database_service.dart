import 'package:todo_app/src/core/database/database_fetch_params.dart';
import 'package:todo_app/src/core/database/database_provider.dart';
import 'package:todo_app/src/data/models/notification_model.dart';
import 'package:todo_app/src/data/models/task_model.dart';

abstract class DatabaseService {
  late DatabaseProvider databaseProvider;

  Future<void> initDatabaseProvider();

  Future<int> createTask({
    required TaskModel taskModel,
  });

  Future<int> createNotification({
    required NotificationModel notificationModel,
  });

  Future<int> deleteAllTasks();

  Future<int> deleteAllNotifications();

  Future<int> deleteSelectedTasks({
    required List<TaskModel> tasks,
  });

  Future<int> deleteSelectedNotifications({
    required List<TaskModel> tasks,
  });

  Future<int> deleteSingleTask({
    required TaskModel task,
  });

  Future<int> deleteSingleTaskNotifications({
    required TaskModel task,
  });

  Future<int> deleteSingleNotification({
    required NotificationModel notification,
  });

  Future<List<Map<String, dynamic>>> fetchAllTasks({
    required DatabaseFetchParams databaseFetchParams,
  });

  Future<List<Map<String, dynamic>>> fetchCompletedTasks({
    required DatabaseFetchParams databaseFetchParams,
  });

  Future<List<Map<String, dynamic>>> fetchUnCompletedTasks({
    required DatabaseFetchParams databaseFetchParams,
  });

  Future<List<Map<String, dynamic>>> fetchFavouriteTasks({
    required DatabaseFetchParams databaseFetchParams,
  });

  Future<List<Map<String, dynamic>>> fetchSelectedTasks({
    required List<TaskModel> tasks,
  });

  Future<List<Map<String, dynamic>>> fetchSingleTask({
    TaskModel? task,
    int? id,
  });

  Future<List<Map<String, dynamic>>> fetchSingleNotification({
    required NotificationModel notification,
  });

  Future<List<Map<String, dynamic>>> fetchAllNotifications({
    required DatabaseFetchParams databaseFetchParams,
  });

  Future<int> markAllTasksAsFavourite();

  Future<int> markAllTasksAsUnFavourite();

  Future<int> markAllTasksAsCompleted();

  Future<int> markAllTasksAsUnCompleted();

  Future<int> markSelectedTasksAsFavourite({
    required List<TaskModel> tasks,
  });

  Future<int> markSelectedTasksAsUnFavourite({
    required List<TaskModel> tasks,
  });

  Future<int> markSelectedTasksAsCompleted({
    required List<TaskModel> tasks,
  });

  Future<int> markSelectedTasksAsUnCompleted({
    required List<TaskModel> tasks,
  });

  Future<int> markSingleTaskAsFavourite({
    required TaskModel task,
  });

  Future<int> markSingleTaskAsUnFavourite({
    required TaskModel task,
  });

  Future<int> markSingleTaskAsCompleted({
    required TaskModel task,
  });

  Future<int> markSingleTaskAsUnCompleted({
    required TaskModel task,
  });

  Future<int> markAllNotificationsAsRead();

  Future<int> markSingleNotificationAsRead({
    NotificationModel? notification,
    String? notifiedAt,
    String? taskUniqueName,
  });

  Future<int> markSingleNotificationAsUnRead({
    required NotificationModel notification,
  });
}
