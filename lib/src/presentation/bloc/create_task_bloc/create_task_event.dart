part of 'create_task_bloc.dart';

@immutable
abstract class CreateTaskEvent {}

class InitializeCreateTask extends CreateTaskEvent {}

class UpdateCreateTask extends CreateTaskEvent {
  final CreateTaskUpdate createTaskUpdate;
  final DateTime? selectedDate;
  final TimeOfDay? selectedStartTime;
  final TimeOfDay? selectedEndTime;
  final int? selectedReminder;
  final int? selectedRepeat;
  final int? selectedColor;
  final String? selectedAudioPath;

  UpdateCreateTask({
    required this.createTaskUpdate,
    this.selectedDate,
    this.selectedStartTime,
    this.selectedEndTime,
    this.selectedReminder,
    this.selectedRepeat,
    this.selectedColor,
    this.selectedAudioPath,
  });
}

class CreateTask extends CreateTaskEvent {}
