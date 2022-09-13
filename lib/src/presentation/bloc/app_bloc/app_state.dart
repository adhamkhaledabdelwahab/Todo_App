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

class AppUpdateAppLaunchTaskState extends AppState {}
