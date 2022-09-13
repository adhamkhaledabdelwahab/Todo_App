part of 'scheduled_tasks_bloc.dart';

@immutable
abstract class ScheduledTasksEvent {}

class ScheduledTasksInitialize extends ScheduledTasksEvent {}

class ScheduledTasksUpdateSelectedDate extends ScheduledTasksEvent {
  final DateTime selectedDate;

  ScheduledTasksUpdateSelectedDate({required this.selectedDate});
}
