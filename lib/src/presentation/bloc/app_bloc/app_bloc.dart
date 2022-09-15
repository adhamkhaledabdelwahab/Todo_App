import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/src/core/constants/board_screen_consts.dart';
import 'package:todo_app/src/core/notification/notification_provider.dart';
import 'package:todo_app/src/core/use_cases/use_cases.dart';
import 'package:todo_app/src/data/models/notification_model.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/domain/use_cases/use_cases.dart';
import 'package:todo_app/src/injection_container.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  late final GetInitAppServices _getInitAppServices;
  late final GetQuerySingleNotification _getQuerySingleNotification;
  TaskModel? appLaunchTask;

  AppBloc({
    required GetInitAppServices getInitAppServices,
    required GetQuerySingleNotification getQuerySingleNotification,
  }) : super(AppInitialState()) {
    _getInitAppServices = getInitAppServices;
    _getQuerySingleNotification = getQuerySingleNotification;
    on<AppInitializeEvent>(_onInitializeApp);
    on<AppUpdateAppLaunchTaskEvent>(_onAppUpdateAppLaunchTaskEvent);
    on<AppMarkAppLaunchTaskNotificationAsReadEvent>(
        _onAppMarkAppLaunchTaskNotificationAsReadEvent);
    on<AppUpdateSelectedTaskNotificationEvent>(
        _onAppUpdateSelectedTaskNotificationEvent);

    appNotificationSelectReceivePort.listen((message) {
      add(AppUpdateSelectedTaskNotificationEvent(message));
      debugPrint('notification select port listener invoked');
    });
  }

  static AppBloc get(BuildContext context) => BlocProvider.of(context);

  Future _updateState(Emitter<AppState> emit, AppState state) async {
    await Future.delayed(const Duration(milliseconds: 100));
    emit(state);
  }

  Future _onInitializeApp(
    AppInitializeEvent event,
    Emitter<AppState> emit,
  ) async {
    await _updateState(emit, AppInitializingState());
    final result = await _getInitAppServices.call(NoParams());
    await result.fold(
      (failure) async {
        await _updateState(
          emit,
          AppInitializingErrorState(
            message: failure.message,
          ),
        );
      },
      (voidR) async {
        await _updateState(emit, AppInitializedState());
      },
    );
  }

  Future _onAppUpdateAppLaunchTaskEvent(
    AppUpdateAppLaunchTaskEvent event,
    Emitter<AppState> emitter,
  ) async {
    FlutterLocalNotificationsPlugin plugin =
        await serviceLocator<NotificationProvider>().notificationPlugin();
    final appDetails = await plugin.getNotificationAppLaunchDetails();
    if (appDetails != null &&
        appDetails.payload != null &&
        appDetails.didNotificationLaunchApp) {
      TaskModel taskModel = TaskModel.fromJson(
        jsonDecode(
          appDetails.payload!,
        ),
      );
      appLaunchTask = taskModel;
      await _updateState(emitter, AppUpdateAppLaunchTaskState(taskModel.id));
    }
  }

  Future _onAppMarkAppLaunchTaskNotificationAsReadEvent(
    AppMarkAppLaunchTaskNotificationAsReadEvent event,
    Emitter<AppState> emitter,
  ) async {
    await _updateState(
        emitter, AppMarkSelectedTaskNotificationAsReadLoadingState());
    final notification = NotificationModel(
      taskUniqueName: "asdasda",
      isRead: 1,
      notifiedAt: "Sdfsdf",
      id: event.id,
    );
    final result = await _getQuerySingleNotification.call(
      QuerySingleNotificationParams(
        querySingleNotification:
            QuerySingleNotification.markSingleNotificationAsRead,
        notification: notification,
      ),
    );
    await result.fold(
      (nResult) async {
        await nResult.fold(
          (fail) async => await _updateState(
            emitter,
            AppMarkSelectedTaskNotificationAsReadLoadingErrorState(
              fail.message,
            ),
          ),
          (notification) async => await _updateState(
            emitter,
            AppMarkSelectedTaskNotificationAsReadLoadedState(),
          ),
        );
      },
      (r) async {},
    );
  }

  Future _onAppUpdateSelectedTaskNotificationEvent(
    AppUpdateSelectedTaskNotificationEvent event,
    Emitter<AppState> emitter,
  ) async {
    appLaunchTask = event.task;
    await _updateState(emitter, AppUpdateSelectedTaskNotificationState());
  }
}
