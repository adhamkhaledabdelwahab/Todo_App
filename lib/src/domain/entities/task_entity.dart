import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String title;
  final String description;
  final String date;
  final String startTime;
  final String endTime;
  final int reminder;
  final int repeat;
  final int color;
  final int isCompleted;
  final int isFavourite;
  final String uniqueName;
  final String audioPath;

  const TaskEntity({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.reminder,
    required this.repeat,
    required this.color,
    required this.isCompleted,
    required this.isFavourite,
    required this.uniqueName,
    required this.audioPath,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        date,
        startTime,
        endTime,
        reminder,
        repeat,
        color,
        isCompleted,
        isFavourite,
        audioPath,
      ];
}
