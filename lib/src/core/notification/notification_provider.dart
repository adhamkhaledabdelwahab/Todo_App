// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:todo_app/src/core/constants/board_screen_consts.dart';
import 'package:todo_app/src/core/database/database.dart';
import 'package:todo_app/src/core/errors/exceptions.dart';
import 'package:todo_app/src/core/utils/fetch_schedule_time_method.dart';
import 'package:todo_app/src/data/data_sources/data_sources.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/injection_container.dart';

class NotificationProvider {
  static final _instance = NotificationProvider._internal();
  static NotificationProvider get = _instance;
  bool isInitialized = false;
  late FlutterLocalNotificationsPlugin _plugin;

  NotificationProvider._internal();

  Future<FlutterLocalNotificationsPlugin> notificationPlugin() async {
    if (!isInitialized) await init();
    return _plugin;
  }

  Future init() async {
    try {
      FlutterLocalNotificationsPlugin plugin =
          FlutterLocalNotificationsPlugin();
      await initializeTimeZone();
      if (Platform.isIOS) {
        await _initializeIOSPermissions(plugin);
      }
      var init = await _initFlutterLocalNotificationPlugin(plugin);
      if (init != null && init == true) {
        _plugin = plugin;
        isInitialized = true;
      }
    } on NotificationInitTimeZonesException {
      throw NotificationInitTimeZonesException();
    } on NotificationIOSPermissionException {
      throw NotificationIOSPermissionException();
    } catch (e) {
      throw NotificationInitializationException();
    }
  }

  Future<bool?> _initFlutterLocalNotificationPlugin(
      FlutterLocalNotificationsPlugin notificationsPlugin) async {
    return await notificationsPlugin.initialize(
      _getInitializationSettings(),
      onSelectNotification: _selectNotification,
    );
  }

  Future<void> _initializeIOSPermissions(
      FlutterLocalNotificationsPlugin notificationsPlugin) async {
    try {
      var isGained = await notificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      if (isGained == null || isGained == false) {
        throw NotificationIOSPermissionException();
      }
    } catch (e) {
      throw NotificationIOSPermissionException();
    }
  }

  static Future<void> initializeTimeZone() async {
    try {
      tz.initializeTimeZones();
      final String timeZoneName =
          await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (e) {
      throw NotificationInitTimeZonesException();
    }
  }

  InitializationSettings _getInitializationSettings() {
    return InitializationSettings(
      iOS: _getIOSInitializationSettings(),
      android: _getAndroidInitializationSettings(),
    );
  }

  IOSInitializationSettings _getIOSInitializationSettings() {
    return IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );
  }

  AndroidInitializationSettings _getAndroidInitializationSettings() {
    return const AndroidInitializationSettings('res_notification_app_icon');
  }

  Future<void> _selectNotification(String? payload) async {
    try {
      if (payload != null) {
        DatabaseProvider databaseProvider = DatabaseProvider.get;
        await databaseProvider.init();
        DatabaseService databaseService =
            DatabaseServiceImpl(databaseProvider: databaseProvider);
        TaskDatabaseDataSource databaseDataSource =
            TaskDatabaseDataSourceImpl(databaseService: databaseService);
        TaskModel task = TaskModel.fromJson(jsonDecode(payload));
        databaseDataSource.markSingleNotificationAsRead(
          notifiedAt: fetchScheduledExactTime(task).toString(),
          taskUniqueName: task.uniqueName,
        );
        updateUIBackground(port: boardNotificationUpdateIsolateName);
        updateUIBackground(
          port: appNotificationSelectIsolateName,
          task: task,
        );
      } else {
        throw Exception("Error Empty Notification Payload!");
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    debugPrint('Task $id: $title');
  }
}
