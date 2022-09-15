part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}

class AppInitializeEvent extends AppEvent {}

class AppUpdateAppLaunchTaskEvent extends AppEvent {}

class AppUpdateSelectedTaskNotificationEvent extends AppEvent {
  final TaskModel? task;

  AppUpdateSelectedTaskNotificationEvent(this.task);
}

class AppMarkAppLaunchTaskNotificationAsReadEvent extends AppEvent {
  final int? id;

  AppMarkAppLaunchTaskNotificationAsReadEvent(this.id);
}
