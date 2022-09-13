// ignore_for_file: depend_on_referenced_packages

import 'package:todo_app/src/core/notification/notification.dart';
import 'package:todo_app/src/data/models/task_model.dart';

abstract class NotificationService {
  late NotificationProvider notificationProvider;
  late WorkManagerProvider workManagerProvider;

  Future<void> initNotificationService();

  Future<void> scheduleNotification(TaskModel taskModel);

  Future<void> repeatNotification(TaskModel taskModel);

  Future<void> cancelNotification(TaskModel taskModel);

  Future<void> cancelAllNotification();
}
