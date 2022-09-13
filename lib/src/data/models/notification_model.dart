import 'package:todo_app/src/core/constants/database_notification_table_consts.dart';
import 'package:todo_app/src/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    int? id,
    required String taskUniqueName,
    required int isRead,
    required String notifiedAt,
  }) : super(
          id: id,
          taskUniqueName: taskUniqueName,
          isRead: isRead,
          notifiedAt: notifiedAt,
        );

  NotificationModel copyWith({
    int? id,
    String? taskUniqueName,
    int? isRead,
    String? notifiedAt,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        taskUniqueName: taskUniqueName ?? this.taskUniqueName,
        isRead: isRead ?? this.isRead,
        notifiedAt: notifiedAt ?? this.notifiedAt,
      );

  static List<NotificationModel> fromJsonList(
      List<Map<String, dynamic>> jsonList) {
    List<NotificationModel> tasks = [];
    for (var json in jsonList) {
      tasks.add(NotificationModel.fromJson(json));
    }
    return tasks;
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json[notificationColumnId] as int?,
      taskUniqueName: json[notificationColumnTaskUniqueName] as String,
      isRead: json[notificationColumnIsRead] as int,
      notifiedAt: json[notificationColumnNotifiedAt] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        notificationColumnId: id,
        notificationColumnTaskUniqueName: taskUniqueName,
        notificationColumnIsRead: isRead,
        notificationColumnNotifiedAt: notifiedAt,
      };
}
