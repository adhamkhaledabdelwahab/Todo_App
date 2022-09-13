import 'package:todo_app/src/core/constants/database_consts.dart';
import 'package:todo_app/src/core/constants/database_notification_table_consts.dart';
import 'package:todo_app/src/core/database/database.dart';
import 'package:todo_app/src/data/models/notification_model.dart';
import 'package:todo_app/src/data/models/task_model.dart';

class DatabaseServiceImpl implements DatabaseService {
  @override
  DatabaseProvider databaseProvider;

  DatabaseServiceImpl({required this.databaseProvider});

  @override
  Future<void> initDatabaseProvider() async {
    return await databaseProvider.init();
  }

  @override
  Future<int> createNotification({
    required NotificationModel notificationModel,
  }) async {
    final db = await databaseProvider.db();
    return await db.insert(
      notificationTableName,
      notificationModel.toJson(),
    );
  }

  @override
  Future<int> createTask({
    required TaskModel taskModel,
  }) async {
    final db = await databaseProvider.db();
    return await db.insert(
      taskTableName,
      taskModel.toJson(),
    );
  }

  @override
  Future<int> deleteAllTasks() async {
    final db = await databaseProvider.db();
    return await db.delete(taskTableName);
  }

  @override
  Future<int> deleteSelectedTasks({required List<TaskModel> tasks}) async {
    final db = await databaseProvider.db();
    return await db.delete(
      taskTableName,
      where: '$taskColumnId IN (${_getQuestionMarkString(tasks.length)})',
      whereArgs: tasks.map((e) => e.id).toList(),
    );
  }

  @override
  Future<int> deleteAllNotifications() async {
    final db = await databaseProvider.db();
    return await db.delete(notificationTableName);
  }

  @override
  Future<int> deleteSelectedNotifications(
      {required List<TaskModel> tasks}) async {
    final db = await databaseProvider.db();
    return await db.delete(
      notificationTableName,
      where:
          '$notificationColumnTaskUniqueName IN (${_getQuestionMarkString(tasks.length)})',
      whereArgs: tasks.map((e) => e.uniqueName).toList(),
    );
  }

  @override
  Future<int> deleteSingleNotification(
      {required NotificationModel notification}) async {
    final db = await databaseProvider.db();
    return await db.delete(
      notificationTableName,
      where: '$notificationColumnId = ?',
      whereArgs: [notification.id!],
    );
  }

  @override
  Future<int> deleteSingleTask({required TaskModel task}) async {
    final db = await databaseProvider.db();
    return await db.delete(
      taskTableName,
      where: '$taskColumnId = ?',
      whereArgs: [task.id!],
    );
  }

  @override
  Future<int> deleteSingleTaskNotifications({required TaskModel task}) async {
    final db = await databaseProvider.db();
    return await db.delete(
      notificationTableName,
      where: '$notificationColumnTaskUniqueName = ?',
      whereArgs: [task.uniqueName],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllNotifications({
    required DatabaseFetchParams databaseFetchParams,
  }) async {
    final db = await databaseProvider.db();
    return await db.query(
      notificationTableName,
      limit: databaseFetchParams.limit,
      offset: databaseFetchParams.offset,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllTasks({
    required DatabaseFetchParams databaseFetchParams,
  }) async {
    final db = await databaseProvider.db();
    return await db.query(
      taskTableName,
      limit: databaseFetchParams.limit,
      offset: databaseFetchParams.offset,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> fetchCompletedTasks({
    required DatabaseFetchParams databaseFetchParams,
  }) async {
    final db = await databaseProvider.db();
    return await db.query(
      taskTableName,
      where: '$taskColumnIsCompleted = ?',
      whereArgs: [
        1,
      ],
      limit: databaseFetchParams.limit,
      offset: databaseFetchParams.offset,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> fetchFavouriteTasks({
    required DatabaseFetchParams databaseFetchParams,
  }) async {
    final db = await databaseProvider.db();
    return await db.query(
      taskTableName,
      where: '$taskColumnIsFavourite = ?',
      whereArgs: [
        1,
      ],
      limit: databaseFetchParams.limit,
      offset: databaseFetchParams.offset,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> fetchSelectedTasks(
      {required List<TaskModel> tasks}) async {
    final db = await databaseProvider.db();
    return await db.query(
      taskTableName,
      where:
          '$taskColumnUniqueName IN (${_getQuestionMarkString(tasks.length)})',
      whereArgs: tasks.map((e) => e.uniqueName).toList(),
    );
  }

  @override
  Future<List<Map<String, dynamic>>> fetchSingleTask(
      {TaskModel? task, int? id}) async {
    final db = await databaseProvider.db();
    return await db.query(
      taskTableName,
      where:
          '${task == null && id != null ? taskColumnId : taskColumnUniqueName} = ?',
      whereArgs: [
        task == null && id != null ? id : task!.uniqueName,
      ],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> fetchSingleNotification(
      {required NotificationModel notification}) async {
    final db = await databaseProvider.db();
    return await db.query(
      notificationTableName,
      where: '$notificationColumnId = ?',
      whereArgs: [
        notification.id,
      ],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> fetchUnCompletedTasks({
    required DatabaseFetchParams databaseFetchParams,
  }) async {
    final db = await databaseProvider.db();
    return await db.query(
      taskTableName,
      where: '$taskColumnIsCompleted = ?',
      whereArgs: [
        0,
      ],
      limit: databaseFetchParams.limit,
      offset: databaseFetchParams.offset,
    );
  }

  @override
  Future<int> markAllNotificationsAsRead() async {
    final db = await databaseProvider.db();
    return await db.rawUpdate(
      'UPDATE $notificationTableName '
      'Set $notificationColumnIsRead = ?',
      [
        1,
      ],
    );
  }

  @override
  Future<int> markAllTasksAsCompleted() async {
    final db = await databaseProvider.db();
    return await db.rawUpdate(
      'UPDATE $taskTableName '
      'Set $taskColumnIsCompleted = ?',
      [
        1,
      ],
    );
  }

  @override
  Future<int> markAllTasksAsFavourite() async {
    final db = await databaseProvider.db();
    return await db.rawUpdate(
      'UPDATE $taskTableName '
      'Set $taskColumnIsFavourite = ?',
      [
        1,
      ],
    );
  }

  @override
  Future<int> markAllTasksAsUnCompleted() async {
    final db = await databaseProvider.db();
    return await db.rawUpdate(
      'UPDATE $taskTableName '
      'Set $taskColumnIsCompleted = ?',
      [
        0,
      ],
    );
  }

  @override
  Future<int> markAllTasksAsUnFavourite() async {
    final db = await databaseProvider.db();
    return await db.rawUpdate(
      'UPDATE $taskTableName '
      'Set $taskColumnIsFavourite = ?',
      [
        0,
      ],
    );
  }

  @override
  Future<int> markSelectedTasksAsCompleted(
      {required List<TaskModel> tasks}) async {
    final db = await databaseProvider.db();
    return await db.rawUpdate(
      'UPDATE $taskTableName '
      'Set $taskColumnIsCompleted = ? '
      'WHERE $taskColumnId IN (${_getQuestionMarkString(tasks.length)})',
      [
        1,
        ...tasks.map((e) => e.id).toList(),
      ],
    );
  }

  @override
  Future<int> markSelectedTasksAsFavourite(
      {required List<TaskModel> tasks}) async {
    final db = await databaseProvider.db();
    return await db.rawUpdate(
      'UPDATE $taskTableName '
      'Set $taskColumnIsFavourite = ? '
      'WHERE $taskColumnId IN (${_getQuestionMarkString(tasks.length)})',
      [
        1,
        ...tasks.map((e) => e.id).toList(),
      ],
    );
  }

  @override
  Future<int> markSelectedTasksAsUnCompleted(
      {required List<TaskModel> tasks}) async {
    final db = await databaseProvider.db();
    return await db.rawUpdate(
      'UPDATE $taskTableName '
      'Set $taskColumnIsCompleted = ? '
      'WHERE $taskColumnId IN (${_getQuestionMarkString(tasks.length)})',
      [
        0,
        ...tasks.map((e) => e.id).toList(),
      ],
    );
  }

  @override
  Future<int> markSelectedTasksAsUnFavourite(
      {required List<TaskModel> tasks}) async {
    final db = await databaseProvider.db();
    return await db.rawUpdate(
      'UPDATE $taskTableName '
      'Set $taskColumnIsFavourite = ? '
      'WHERE $taskColumnId IN (${_getQuestionMarkString(tasks.length)})',
      [
        0,
        ...tasks.map((e) => e.id).toList(),
      ],
    );
  }

  @override
  Future<int> markSingleNotificationAsRead({
    NotificationModel? notification,
    String? notifiedAt,
    String? taskUniqueName,
  }) async {
    final db = await databaseProvider.db();
    String where = notification != null
        ? 'WHERE $notificationColumnId = ?'
        : 'WHERE $notificationColumnNotifiedAt = ? AND $notificationColumnTaskUniqueName = ?';
    return await db.rawUpdate(
      'UPDATE $notificationTableName '
      'Set $notificationColumnIsRead = ? '
      '$where',
      notification != null
          ? [
              1,
              notification.id,
            ]
          : [
              1,
              notifiedAt,
              taskUniqueName,
            ],
    );
  }

  @override
  Future<int> markSingleNotificationAsUnRead(
      {required NotificationModel notification}) async {
    final db = await databaseProvider.db();
    return await db.rawUpdate(
      'UPDATE $notificationTableName '
      'Set $notificationColumnIsRead = ? '
      'WHERE $notificationColumnId = ?',
      [
        0,
        notification.id,
      ],
    );
  }

  @override
  Future<int> markSingleTaskAsCompleted({required TaskModel task}) async {
    final db = await databaseProvider.db();
    return await db.rawUpdate(
      'UPDATE $taskTableName '
      'Set $taskColumnIsCompleted = ? '
      'WHERE $taskColumnId = ?',
      [
        1,
        task.id,
      ],
    );
  }

  @override
  Future<int> markSingleTaskAsFavourite({required TaskModel task}) async {
    final db = await databaseProvider.db();
    return await db.rawUpdate(
      'UPDATE $taskTableName '
      'Set $taskColumnIsFavourite = ? '
      'WHERE $taskColumnId = ?',
      [
        1,
        task.id,
      ],
    );
  }

  @override
  Future<int> markSingleTaskAsUnCompleted({required TaskModel task}) async {
    final db = await databaseProvider.db();
    return await db.rawUpdate(
      'UPDATE $taskTableName '
      'Set $taskColumnIsCompleted = ? '
      'WHERE $taskColumnId = ?',
      [
        0,
        task.id,
      ],
    );
  }

  @override
  Future<int> markSingleTaskAsUnFavourite({required TaskModel task}) async {
    final db = await databaseProvider.db();
    return await db.rawUpdate(
      'UPDATE $taskTableName '
      'Set $taskColumnIsFavourite = ? '
      'WHERE $taskColumnId = ?',
      [
        0,
        task.id,
      ],
    );
  }

  String _getQuestionMarkString(int number) {
    String list = '';
    for (int i = 0; i < number; i++) {
      if (i == number - 1) {
        list += '?';
      } else {
        list += '?, ';
      }
    }
    return list;
  }
}
