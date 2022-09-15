import 'dart:isolate';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:notifications_listener_service/notifications_listener_service.dart';
import 'package:todo_app/src/core/constants/board_screen_consts.dart';
import 'package:todo_app/src/core/database/database.dart';
import 'package:todo_app/src/core/notification/notification.dart';
import 'package:todo_app/src/core/utils/fetch_schedule_time_method.dart';
import 'package:todo_app/src/data/data_sources/data_sources.dart';
import 'package:todo_app/src/data/models/notification_model.dart';
import 'package:todo_app/src/data/models/task_model.dart';

const String audioPlayerId = "TODO_AUDIO_PLAYER_ID";
final audioPlayer = AudioPlayer(playerId: audioPlayerId);

void onNotificationStateChanges() {
  NotificationServicePlugin.instance.executeNotificationListener((evt) async {
    try {
      debugPrint("Notification Listener Service CallBackMethod Start");
      if (evt?.state == NotificationState.post) {
        TaskDatabaseDataSource dataSource = await _dbDataSource();
        TaskModel task = await dataSource.fetchSingleTask(id: evt!.id!);
        NotificationModel notification = await generateNotificationModel(task);
        await dataSource.createNotification(
          notificationModel: notification,
        );
        updateUIBackground(port: boardNotificationUpdateIsolateName);
        if (audioPlayer.state == PlayerState.playing) {
          await audioPlayer.stop();
        }
        if (task.audioPath.isNotEmpty) {
          audioPlayer.setReleaseMode(ReleaseMode.loop);
          await audioPlayer.play(
            DeviceFileSource(task.audioPath),
          );
          Future.delayed(const Duration(minutes: 2))
              .then((value) async => await audioPlayer.stop());
        }
      } else if (evt?.state == NotificationState.remove) {
        if (audioPlayer.state == PlayerState.playing) {
          await audioPlayer.stop();
        }
      }
      debugPrint("Notification Listener Service CallBackMethod End");
    } catch (e) {
      debugPrint(
          'Error Add Notification Into Database On Notification Listener Service Background Execute: $e');
    }
  });
}

Future<TaskDatabaseDataSource> _dbDataSource() async {
  DatabaseProvider databaseProvider = DatabaseProvider.get;
  await databaseProvider.init();
  DatabaseService databaseService =
      DatabaseServiceImpl(databaseProvider: databaseProvider);
  TaskDatabaseDataSource databaseDataSource =
      TaskDatabaseDataSourceImpl(databaseService: databaseService);
  return databaseDataSource;
}

Future<NotificationModel> generateNotificationModel(TaskModel task) async {
  await NotificationProvider.initializeTimeZone();
  NotificationModel notification = NotificationModel(
    taskUniqueName: task.uniqueName,
    isRead: 0,
    notifiedAt: fetchScheduledExactTime(task).toString(),
  );
  return notification;
}

void updateUIBackground({required String port, TaskModel? task}) {
  SendPort? uiSendPort = IsolateNameServer.lookupPortByName(port);
  debugPrint("port with name $port is $uiSendPort");
  if (uiSendPort != null) {
    if (task != null) {
      uiSendPort.send(task);
    } else {
      uiSendPort.send(true);
    }
  }
}
