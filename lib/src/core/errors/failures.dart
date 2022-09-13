import 'package:equatable/equatable.dart';
import 'package:todo_app/src/core/constants/failure_messages.dart';

abstract class Failures extends Equatable {
  final String message;

  const Failures(this.message);

  @override
  List<Object> get props => [message];
}

class DatabaseFetchingPathFailure extends Failures {
  const DatabaseFetchingPathFailure() : super(databaseFetchingPathErrMsg);
}

class DatabaseCreatingTaskTableFailure extends Failures {
  const DatabaseCreatingTaskTableFailure()
      : super(databaseCreatingTaskTableErrMsg);
}

class DatabaseCreatingNotificationTableFailure extends Failures {
  const DatabaseCreatingNotificationTableFailure()
      : super(databaseCreatingNotificationTableErrMsg);
}

class DatabaseInitializationFailure extends Failures {
  const DatabaseInitializationFailure() : super(databaseInitializationErrMsg);
}

class DatabaseCreateTaskFailure extends Failures {
  const DatabaseCreateTaskFailure() : super(databaseCreateTaskErrMsg);
}

class DatabaseFetchSingleTaskFailure extends Failures {
  const DatabaseFetchSingleTaskFailure() : super(databaseFetchSingleTaskErrMsg);
}

class DatabaseDeleteAllTasksFailure extends Failures {
  const DatabaseDeleteAllTasksFailure() : super(databaseDeleteAllTasksErrMsg);
}

class DatabaseDeleteSingleTaskFailure extends Failures {
  const DatabaseDeleteSingleTaskFailure()
      : super(databaseDeleteSingleTaskErrMsg);
}

class DatabaseDeletingSingleTaskNotificationsFailure extends Failures {
  const DatabaseDeletingSingleTaskNotificationsFailure()
      : super(databaseDeletingSingleTaskNotificationsErrMsg);
}

class DatabaseFetchAllTasksFailure extends Failures {
  const DatabaseFetchAllTasksFailure() : super(databaseFetchAllTasksErrMsg);
}

class DatabaseDeleteSelectedTasksFailure extends Failures {
  const DatabaseDeleteSelectedTasksFailure()
      : super(databaseDeleteSelectedTasksErrMsg);
}

class DatabaseDeleteAllNotificationsFailure extends Failures {
  const DatabaseDeleteAllNotificationsFailure()
      : super(databaseDeleteAllNotificationsErrMsg);
}

class DatabaseDeleteSelectedNotificationsFailure extends Failures {
  const DatabaseDeleteSelectedNotificationsFailure()
      : super(databaseDeleteSelectedNotificationsErrMsg);
}

class DatabaseDeleteSingleNotificationFailure extends Failures {
  const DatabaseDeleteSingleNotificationFailure()
      : super(databaseDeleteSingleNotificationErrMsg);
}

class DatabaseFetchAllNotificationsFailure extends Failures {
  const DatabaseFetchAllNotificationsFailure()
      : super(databaseFetchAllNotificationsErrMsg);
}

class DatabaseFetchCompletedTasksFailure extends Failures {
  const DatabaseFetchCompletedTasksFailure()
      : super(databaseFetchCompletedTasksErrMsg);
}

class DatabaseFetchFavouriteTasksFailure extends Failures {
  const DatabaseFetchFavouriteTasksFailure()
      : super(databaseFetchFavouriteTasksErrMsg);
}

class DatabaseFetchUnCompletedTasksFailure extends Failures {
  const DatabaseFetchUnCompletedTasksFailure()
      : super(databaseFetchUnCompletedTasksErrMsg);
}

class DatabaseMarkAllNotificationAsReadFailure extends Failures {
  const DatabaseMarkAllNotificationAsReadFailure()
      : super(databaseMarkAllNotificationAsReadErrMsg);
}

class DatabaseMarkAllTasksAsCompletedFailure extends Failures {
  const DatabaseMarkAllTasksAsCompletedFailure()
      : super(databaseMarkAllTasksAsCompletedErrMsg);
}

class DatabaseMarkAllTasksAsFavouriteFailure extends Failures {
  const DatabaseMarkAllTasksAsFavouriteFailure()
      : super(databaseMarkAllTasksAsFavouriteErrMsg);
}

class DatabaseMarkAllTasksAsUnCompletedFailure extends Failures {
  const DatabaseMarkAllTasksAsUnCompletedFailure()
      : super(databaseMarkAllTasksAsUnCompletedErrMsg);
}

class DatabaseMarkAllTasksAsUnFavouriteFailure extends Failures {
  const DatabaseMarkAllTasksAsUnFavouriteFailure()
      : super(databaseMarkAllTasksAsUnFavouriteErrMsg);
}

class DatabaseFetchSelectedTasksFailure extends Failures {
  const DatabaseFetchSelectedTasksFailure()
      : super(databaseFetchSelectedTasksErrMsg);
}

class DatabaseMarkSelectedTasksAsCompletedFailure extends Failures {
  const DatabaseMarkSelectedTasksAsCompletedFailure()
      : super(databaseMarkSelectedTasksAsCompletedErrMsg);
}

class DatabaseMarkSelectedTasksAsFavouriteFailure extends Failures {
  const DatabaseMarkSelectedTasksAsFavouriteFailure()
      : super(databaseMarkSelectedTasksAsFavouriteErrMsg);
}

class DatabaseMarkSelectedTasksAsUnCompletedFailure extends Failures {
  const DatabaseMarkSelectedTasksAsUnCompletedFailure()
      : super(databaseMarkSelectedTasksAsUnCompletedErrMsg);
}

class DatabaseMarkSelectedTasksAsUnFavouriteFailure extends Failures {
  const DatabaseMarkSelectedTasksAsUnFavouriteFailure()
      : super(databaseMarkSelectedTasksAsUnFavouriteErrMsg);
}

class DatabaseFetchSingleNotificationFailure extends Failures {
  const DatabaseFetchSingleNotificationFailure()
      : super(databaseFetchSingleNotificationErrMsg);
}

class DatabaseMarkSingleNotificationAsReadFailure extends Failures {
  const DatabaseMarkSingleNotificationAsReadFailure()
      : super(databaseMarkSingleNotificationAsReadErrMsg);
}

class DatabaseMarkSingleNotificationAsUnReadFailure extends Failures {
  const DatabaseMarkSingleNotificationAsUnReadFailure()
      : super(databaseMarkSingleNotificationAsUnReadErrMsg);
}

class DatabaseMarkSingleTaskAsCompletedFailure extends Failures {
  const DatabaseMarkSingleTaskAsCompletedFailure()
      : super(databaseMarkSingleTaskAsCompletedErrMsg);
}

class DatabaseMarkSingleTaskAsFavouriteFailure extends Failures {
  const DatabaseMarkSingleTaskAsFavouriteFailure()
      : super(databaseMarkSingleTaskAsFavouriteErrMsg);
}

class DatabaseMarkSingleTaskAsUnCompletedFailure extends Failures {
  const DatabaseMarkSingleTaskAsUnCompletedFailure()
      : super(databaseMarkSingleTaskAsUnCompletedErrMsg);
}

class DatabaseMarkSingleTaskAsUnFavouriteFailure extends Failures {
  const DatabaseMarkSingleTaskAsUnFavouriteFailure()
      : super(databaseMarkSingleTaskAsUnFavouriteErrMsg);
}

class NotificationInitTimeZonesFailure extends Failures {
  const NotificationInitTimeZonesFailure()
      : super(notificationInitTimeZonesErrMsg);
}

class NotificationIOSPermissionFailure extends Failures {
  const NotificationIOSPermissionFailure()
      : super(notificationIOSPermissionErrMsg);
}

class NotificationInitializationFailure extends Failures {
  const NotificationInitializationFailure()
      : super(notificationInitializationErrMsg);
}

class NotificationWorkManagerInitializationFailure extends Failures {
  const NotificationWorkManagerInitializationFailure()
      : super(notificationWorkManagerInitializationErrMsg);
}

class NotificationCancelALlFailure extends Failures {
  const NotificationCancelALlFailure() : super(notificationCancelALlErrMsg);
}

class NotificationCancelSingleFailure extends Failures {
  const NotificationCancelSingleFailure()
      : super(notificationCancelSingleErrMsg);
}

class NotificationCancelSelectedFailure extends Failures {
  const NotificationCancelSelectedFailure()
      : super(notificationCancelSelectedErrMsg);
}

class NotificationScheduleFailure extends Failures {
  const NotificationScheduleFailure() : super(notificationScheduleErrMsg);
}

class NotificationRepeatFailure extends Failures {
  const NotificationRepeatFailure() : super(notificationRepeatErrMsg);
}
