import 'dart:isolate';

const Map<int, String> boardAppbarActions = {
  0: 'Delete All Tasks',
  1: 'Add All Tasks To Favourite',
  2: 'Delete All Tasks From Favourites',
  3: 'Mark All Tasks Completed',
  4: 'Mark All Tasks UnCompleted',
};

const tabsText = [
  'All',
  'Completed',
  'Uncompleted',
  'Favourite',
];

const String boardNotificationUpdateIsolateName =
    'Board_Notification_Update_Isolate_Name';
final ReceivePort boardNotificationUpdateReceivePort = ReceivePort();

const String appNotificationSelectIsolateName =
    'App_Notification_Select_Isolate_Name';
final ReceivePort appNotificationSelectReceivePort = ReceivePort();

const String deletingAllTasksLoadingText = 'Deleting all tasks in progress...';

const String markAllTasksFavouriteLoadingText =
    'Adding all tasks to favourite in progress...';

const String markAllTasksUnFavouriteLoadingText =
    'Deleting all tasks from favourite in progress...';

const String markAllTasksCompletedLoadingText =
    'Marking all tasks as completed in progress...';

const String markAllTasksUnCompletedLoadingText =
    'Marking all tasks as uncompleted in progress...';

const String deletingSelectedTasksLoadingText =
    'Deleting selected tasks in progress...';

const String markSelectedTasksFavouriteLoadingText =
    'Adding selected tasks to favourite in progress...';

const String markSelectedTasksUnFavouriteLoadingText =
    'Deleting selected tasks from favourite in progress...';

const String markSelectedTasksCompletedLoadingText =
    'Marking selected tasks as completed in progress...';

const String markSelectedTasksUnCompletedLoadingText =
    'Marking selected tasks as uncompleted in progress...';
