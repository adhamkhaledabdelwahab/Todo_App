part of 'board_bloc.dart';

@immutable
abstract class BoardEvent {}

class BoardFetchAllNotifications extends BoardEvent {}

class BoardFetchAllTasks extends BoardEvent {}

class BoardFetchCompletedTasks extends BoardEvent {}

class BoardFetchUnCompletedTasks extends BoardEvent {}

class BoardFetchFavouriteTasks extends BoardEvent {}

class BoardDeleteAllTasks extends BoardEvent {}

class BoardMarkAllTasksAsCompleted extends BoardEvent {}

class BoardMarkAllTasksAsUnCompleted extends BoardEvent {}

class BoardMarkAllTasksAsFavourite extends BoardEvent {}

class BoardMarkAllTasksAsUnFavourite extends BoardEvent {}

class BoardDeleteSelectedTasks extends BoardEvent {
  final List<TaskModel> tasks;

  BoardDeleteSelectedTasks({required this.tasks});
}

class BoardMarkSelectedTasksAsCompleted extends BoardEvent {
  final List<TaskModel> tasks;

  BoardMarkSelectedTasksAsCompleted({required this.tasks});
}

class BoardMarkSelectedTasksAsUnCompleted extends BoardEvent {
  final List<TaskModel> tasks;

  BoardMarkSelectedTasksAsUnCompleted({required this.tasks});
}

class BoardMarkSelectedTasksAsFavourite extends BoardEvent {
  final List<TaskModel> tasks;

  BoardMarkSelectedTasksAsFavourite({required this.tasks});
}

class BoardMarkSelectedTasksAsUnFavourite extends BoardEvent {
  final List<TaskModel> tasks;

  BoardMarkSelectedTasksAsUnFavourite({required this.tasks});
}

class BoardDeleteSingleNotification extends BoardEvent {
  final NotificationModel notification;

  BoardDeleteSingleNotification({required this.notification});
}

class BoardMarkSingleNotificationAsRead extends BoardEvent {
  final NotificationModel notification;

  BoardMarkSingleNotificationAsRead({required this.notification});
}

class BoardMarkSingleNotificationAsUnRead extends BoardEvent {
  final NotificationModel notification;

  BoardMarkSingleNotificationAsUnRead({required this.notification});
}

class BoardMarkAllNotificationsAsRead extends BoardEvent {
  BoardMarkAllNotificationsAsRead();
}

class BoardDeleteSingleTask extends BoardEvent {
  final TaskModel task;

  BoardDeleteSingleTask({required this.task});
}

class BoardMarkSingleTaskAsCompleted extends BoardEvent {
  final TaskModel task;

  BoardMarkSingleTaskAsCompleted({required this.task});
}

class BoardMarkSingleTaskAsUnCompleted extends BoardEvent {
  final TaskModel task;

  BoardMarkSingleTaskAsUnCompleted({required this.task});
}

class BoardMarkSingleTaskAsFavourite extends BoardEvent {
  final TaskModel task;

  BoardMarkSingleTaskAsFavourite({required this.task});
}

class BoardMarkSingleTaskAsUnFavourite extends BoardEvent {
  final TaskModel task;

  BoardMarkSingleTaskAsUnFavourite({required this.task});
}

class BoardUpdateTasksAfterCreate extends BoardEvent {
  final TaskModel task;

  BoardUpdateTasksAfterCreate({required this.task});
}

class BoardUpdateSelectedTasks extends BoardEvent {
  final TaskModel task;
  final UpdateSelectedTasks updateSelectedTasks;
  final bool isAdding;

  BoardUpdateSelectedTasks({
    required this.task,
    required this.updateSelectedTasks,
    required this.isAdding,
  });
}
