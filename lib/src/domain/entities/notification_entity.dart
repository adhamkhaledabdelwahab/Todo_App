import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final int? id;
  final String taskUniqueName;
  final int isRead;
  final String notifiedAt;

  const NotificationEntity({
    this.id,
    required this.taskUniqueName,
    required this.isRead,
    required this.notifiedAt,
  });

  @override
  List<Object?> get props => [
        id,
        taskUniqueName,
        isRead,
        notifiedAt,
      ];
}
