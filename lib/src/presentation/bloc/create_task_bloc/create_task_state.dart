part of 'create_task_bloc.dart';

@immutable
abstract class CreateTaskState {}

class CreateTaskInitialState extends CreateTaskState {}

class CreateTaskInitializingState extends CreateTaskState {}

class CreateTaskInitializedState extends CreateTaskState {}

class CreateTaskInitializingErrorState extends CreateTaskState {
  final String errMessage;

  CreateTaskInitializingErrorState({required this.errMessage});
}

class CreateTaskUpdatingState extends CreateTaskState {}

class CreateTaskUpdatedState extends CreateTaskState {}

class CreateTaskUpdatingErrorState extends CreateTaskState {
  final String errMessage;

  CreateTaskUpdatingErrorState({required this.errMessage});
}

class TaskCreatingState extends CreateTaskState {}

class TaskCreatedState extends CreateTaskState {
  final TaskModel task;

  TaskCreatedState({
    required this.task,
  });
}

class TaskCreatingErrorState extends CreateTaskState {
  final String errMessage;

  TaskCreatingErrorState({required this.errMessage});
}
