// ignore_for_file: depend_on_referenced_packages

import 'dart:isolate';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notifications_listener_service/notifications_listener_service.dart';
import 'package:todo_app/src/core/constants/board_screen_consts.dart';
import 'package:todo_app/src/core/database/database.dart';
import 'package:todo_app/src/core/notification/notification.dart';
import 'package:todo_app/src/core/utils/fetch_schedule_time_method.dart';
import 'package:todo_app/src/data/data_sources/data_sources.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/data/repository/task_repository_impl.dart';
import 'package:todo_app/src/domain/repository/task_repository.dart';
import 'package:todo_app/src/domain/use_cases/use_cases.dart';
import 'package:todo_app/src/presentation/bloc/bloc.dart';

import 'data/models/notification_model.dart';

final serviceLocator = GetIt.instance;
const String audioPlayerId = "TODO_AUDIO_PLAYER_ID";
final audioPlayer = AudioPlayer(playerId: audioPlayerId);
final plugin = NotificationServicePlugin.instance;

Future<void> init() async {
  /// Bloc
  serviceLocator.registerFactory(
    () => AppBloc(
      getInitAppServices: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => BoardBloc(
      getFetchNotifications: serviceLocator(),
      getFetchTasks: serviceLocator(),
      getQueryAllNotifications: serviceLocator(),
      getQueryAllTasks: serviceLocator(),
      getQuerySelectedTasks: serviceLocator(),
      getQuerySingleNotification: serviceLocator(),
      getQuerySingleTask: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => CreateTaskBloc(
      getQuerySingleTask: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => ScheduledTasksBloc(
      getFetchTasks: serviceLocator(),
    ),
  );

  /// Use cases
  serviceLocator.registerLazySingleton(
    () => GetInitAppServices(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetFetchNotifications(
      taskRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetFetchTasks(
      taskRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetQueryAllNotifications(
      taskRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetQueryAllTasks(
      taskRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetQuerySelectedTasks(
      taskRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetQuerySingleNotification(
      taskRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetQuerySingleTask(
      taskRepository: serviceLocator(),
    ),
  );

  /// Repository
  serviceLocator.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      taskDatabaseDataSource: serviceLocator(),
      taskNotificationDataSource: serviceLocator(),
    ),
  );

  /// Data sources
  serviceLocator.registerLazySingleton<TaskDatabaseDataSource>(
    () => TaskDatabaseDataSourceImpl(
      databaseService: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<TaskNotificationDataSource>(
    () => TaskNotificationDataSourceImpl(
      notificationService: serviceLocator(),
    ),
  );

  /// Core
  serviceLocator.registerLazySingleton<NotificationService>(
    () => NotificationServiceImpl(
      workManagerProvider: serviceLocator(),
      notificationProvider: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DatabaseService>(
    () => DatabaseServiceImpl(
      databaseProvider: serviceLocator(),
    ),
  );

  /// External
  serviceLocator.registerLazySingleton<WorkManagerProvider>(
    () => WorkManagerProvider.get,
  );
  serviceLocator.registerLazySingleton<NotificationProvider>(
    () => NotificationProvider.get,
  );
  serviceLocator.registerLazySingleton<DatabaseProvider>(
    () => DatabaseProvider.get,
  );

  await plugin.initialize(onNotificationStateChanges);
}

Future<void> onNotificationStateChanges(NotificationEvent? evt) async {
  try {
    debugPrint("Notification Listener Service CallBackMethod Start");
    debugPrint("Notification Listener Service State: ${evt?.state}");
    if (evt?.state == NotificationState.post) {
      TaskDatabaseDataSource dataSource = await _dbDataSource();
      TaskModel task = await _fetchSelectedTask(dataSource, evt!.id!);
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

Future<TaskModel> _fetchSelectedTask(
  TaskDatabaseDataSource databaseDataSource,
  int id,
) async {
  return await databaseDataSource.fetchSingleTask(id: id);
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
