part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}

class AppInitializeEvent extends AppEvent {}

class AppUpdateAppLaunchTaskEvent extends AppEvent {
  final TaskModel? task;

  AppUpdateAppLaunchTaskEvent(this.task);
}
