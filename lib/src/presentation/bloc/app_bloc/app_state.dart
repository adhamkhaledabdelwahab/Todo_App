part of 'app_bloc.dart';

@immutable
abstract class AppState {}

class AppInitialState extends AppState {}

class AppInitializingState extends AppState {}

class AppInitializedState extends AppState {}

class AppInitializingErrorState extends AppState {
  final String message;

  AppInitializingErrorState({required this.message});
}

class AppUpdateAppLaunchTaskState extends AppState {
  final int? id;

  AppUpdateAppLaunchTaskState(this.id);
}

class AppUpdateSelectedTaskNotificationState extends AppState {}

class AppMarkSelectedTaskNotificationAsReadLoadingState extends AppState {}

class AppMarkSelectedTaskNotificationAsReadLoadedState extends AppState {}

class AppMarkSelectedTaskNotificationAsReadLoadingErrorState extends AppState {
  final String message;

  AppMarkSelectedTaskNotificationAsReadLoadingErrorState(this.message);
}
