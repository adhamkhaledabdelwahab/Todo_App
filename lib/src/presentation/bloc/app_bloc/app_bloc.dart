import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/src/core/constants/board_screen_consts.dart';
import 'package:todo_app/src/core/notification/notification_provider.dart';
import 'package:todo_app/src/core/use_cases/use_cases.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/domain/use_cases/init_app_services.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/injection_container.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final GetInitAppServices getInitAppServices;
  TaskModel? appLaunchTask;

  AppBloc({required this.getInitAppServices}) : super(AppInitialState()) {
    on<AppInitializeEvent>(_onInitializeApp);
    on<AppUpdateAppLaunchTaskEvent>(_onAppUpdateAppLaunchTaskEvent);
    appNotificationSelectReceivePort.listen((message) {
      add(AppUpdateAppLaunchTaskEvent(message));
      debugPrint('notification select port listener invoked');
    });
  }

  static AppBloc get(BuildContext context) => BlocProvider.of(context);

  Future _onAppUpdateAppLaunchTaskEvent(
    AppUpdateAppLaunchTaskEvent event,
    Emitter<AppState> emitter,
  ) async {
    appLaunchTask = event.task;
    await _updateState(emitter, AppUpdateAppLaunchTaskState());
  }

  Future _updateState(Emitter<AppState> emit, AppState state) async {
    await Future.delayed(const Duration(milliseconds: 100));
    emit(state);
  }

  Future _onInitializeApp(
    AppInitializeEvent event,
    Emitter<AppState> emit,
  ) async {
    await _updateState(emit, AppInitializingState());
    await _getAppLaunchNotificationSelect();
    final result = await getInitAppServices.call(NoParams());
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

  Future _getAppLaunchNotificationSelect() async {
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
      add(AppUpdateAppLaunchTaskEvent(taskModel));
    }
  }
}
