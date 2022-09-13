part of 'scheduled_tasks_bloc.dart';

@immutable
abstract class ScheduledTasksState {}

class ScheduledTasksInitialState extends ScheduledTasksState {}

class ScheduledTasksInitializingState extends ScheduledTasksState {}

class ScheduledTasksInitializedState extends ScheduledTasksState {}

class ScheduledTasksInitializingErrorState extends ScheduledTasksState {
  final String errMessage;

  ScheduledTasksInitializingErrorState({required this.errMessage});
}

class ScheduledTasksSelectedDateUpdatingState extends ScheduledTasksState {}

class ScheduledTasksSelectedDateUpdatedState extends ScheduledTasksState {}

class ScheduledTasksSelectedDateUpdatingErrorState extends ScheduledTasksState {
  final String errMessage;

  ScheduledTasksSelectedDateUpdatingErrorState({required this.errMessage});
}
