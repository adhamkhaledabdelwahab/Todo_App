// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/src/core/constants/notification_consts.dart';
import 'package:todo_app/src/core/notification/notification.dart';
import 'package:todo_app/src/core/utils/fetch_schedule_time_method.dart';
import 'package:todo_app/src/core/utils/workmanager_callback.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:workmanager/workmanager.dart';

class NotificationServiceImpl implements NotificationService {
  @override
  NotificationProvider notificationProvider;

  @override
  WorkManagerProvider workManagerProvider;

  NotificationServiceImpl({
    required this.notificationProvider,
    required this.workManagerProvider,
  });

  @override
  Future<void> initNotificationService() async {
    await notificationProvider.init();
    await workManagerProvider.init();
  }

  @override
  Future<void> cancelAllNotification() async {
    final plugin = await notificationProvider.notificationPlugin();
    final workManager = await workManagerProvider.workManger();
    await workManager.cancelAll();
    return await plugin.cancelAll();
  }

  @override
  Future<void> cancelNotification(TaskModel taskModel) async {
    final plugin = await notificationProvider.notificationPlugin();
    if (taskModel.repeat != 0) {
      final workManager = await workManagerProvider.workManger();
      await workManager.cancelByUniqueName(taskModel.uniqueName);
    }
    return await plugin.cancel(taskModel.id!);
  }

  @override
  Future<void> repeatNotification(TaskModel taskModel) async {
    final workManager = await workManagerProvider.workManger();
    return await workManager.registerPeriodicTask(
      taskModel.uniqueName,
      repeatNotificationTag,
      inputData: taskModel.toJson(),
      frequency: _getRepeatFreq(taskModel.repeat),
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }

  Duration? _getRepeatFreq(int index) {
    switch (index) {
      case 1:
        return const Duration(days: 1);
      case 2:
        return const Duration(days: 6);
      case 3:
        return const Duration(days: 27);
      default:
        return null;
    }
  }

  @override
  Future<void> scheduleNotification(TaskModel taskModel) async {
    final plugin = await notificationProvider.notificationPlugin();
    tz.TZDateTime scheduleDate = fetchScheduledExactTime(taskModel);
    return await plugin.zonedSchedule(
      taskModel.id!,
      taskModel.title,
      taskModel.description,
      scheduleDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
          channelDescription: channelDesc,
          playSound: taskModel.audioPath.isEmpty,
          priority: Priority.max,
          importance: Importance.max,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
      payload: jsonEncode(taskModel),
    );
  }
}
