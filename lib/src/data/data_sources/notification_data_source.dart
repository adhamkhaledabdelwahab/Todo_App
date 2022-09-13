import 'package:todo_app/src/core/notification/notification_service.dart';
import 'package:todo_app/src/data/models/task_model.dart';

abstract class TaskNotificationDataSource {
  late NotificationService notificationService;

  Future<void> initNotificationService();

  Future<void> scheduleNotification(TaskModel taskModel);

  Future<void> repeatNotification(TaskModel taskModel);

  Future<void> cancelSingleNotification(TaskModel taskModel);

  Future<void> cancelSelectedNotifications(List<TaskModel> tasks);

  Future<void> cancelAllNotifications();
}
