import 'package:todo_app/src/core/notification/notification.dart';
import 'package:todo_app/src/data/data_sources/notification_data_source.dart';
import 'package:todo_app/src/core/errors/exceptions.dart';
import 'package:todo_app/src/data/models/task_model.dart';

class TaskNotificationDataSourceImpl implements TaskNotificationDataSource {
  @override
  NotificationService notificationService;

  TaskNotificationDataSourceImpl({
    required this.notificationService,
  });

  @override
  Future<void> initNotificationService() async {
    try {
      await notificationService.initNotificationService();
    } on NotificationInitTimeZonesException {
      throw NotificationInitTimeZonesException();
    } on NotificationIOSPermissionException {
      throw NotificationIOSPermissionException();
    } on NotificationWorkManagerInitializationException {
      throw NotificationWorkManagerInitializationException();
    } catch (e) {
      throw NotificationInitializationException();
    }
  }

  @override
  Future<void> cancelAllNotifications() async {
    try {
      return await notificationService.cancelAllNotification();
    } catch (e) {
      throw NotificationCancelALlException();
    }
  }

  @override
  Future<void> cancelSingleNotification(TaskModel taskModel) async {
    try {
      return await notificationService.cancelNotification(taskModel);
    } catch (e) {
      throw NotificationCancelSingleException();
    }
  }

  @override
  Future<void> repeatNotification(TaskModel taskModel) async {
    try {
      return await notificationService.repeatNotification(taskModel);
    } catch (e) {
      throw NotificationRepeatException();
    }
  }

  @override
  Future<void> scheduleNotification(TaskModel taskModel) async {
    try {
      return await notificationService.scheduleNotification(taskModel);
    } catch (e) {
      throw NotificationScheduleException();
    }
  }

  @override
  Future<void> cancelSelectedNotifications(List<TaskModel> tasks) async {
    try {
      for (int i = 0; i < tasks.length; i++) {
        await notificationService.cancelNotification(tasks[i]);
      }
      return;
    } catch (e) {
      throw NotificationCancelSelectedException();
    }
  }
}
