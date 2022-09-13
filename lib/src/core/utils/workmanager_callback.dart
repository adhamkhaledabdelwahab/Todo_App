import 'package:flutter/material.dart';
import 'package:todo_app/src/core/notification/notification.dart';
import 'package:todo_app/src/data/data_sources/data_sources.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:workmanager/workmanager.dart';

const notificationTag = "NOTIFICATION";
const repeatNotificationTag = "REPEAT_NOTIFICATION";

void workMangerNotificationTaskExecute() {
  Workmanager().executeTask((task, inputData) async {
    debugPrint("WorkManager Start");
    try {
      if (inputData != null && task == repeatNotificationTag) {
        debugPrint("WorkManager: Schedule Task");
        TaskModel task = TaskModel.fromJson(inputData);
        await _onRepeatNotification(task);
      }
    } catch (e) {
      debugPrint('$e');
      return Future.error(e);
    }
    debugPrint("WorkManager End");
    return Future.value(true);
  });
}

Future<void> _onRepeatNotification(TaskModel task) async {
  var workManagerProvider = WorkManagerProvider.get;
  var notificationProvider = NotificationProvider.get;
  await workManagerProvider.init();
  await notificationProvider.init();
  NotificationService notificationService = NotificationServiceImpl(
    workManagerProvider: workManagerProvider,
    notificationProvider: notificationProvider,
  );
  TaskNotificationDataSource notificationDataSourceImpl =
      TaskNotificationDataSourceImpl(
    notificationService: notificationService,
  );
  notificationDataSourceImpl.scheduleNotification(task);
}
