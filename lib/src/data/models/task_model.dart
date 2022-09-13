import 'package:todo_app/src/core/constants/database_consts.dart';
import 'package:todo_app/src/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel(
      {int? id,
      required String title,
      required String description,
      required String date,
      required String startTime,
      required String endTime,
      int reminder = 0,
      int repeat = 0,
      int color = 0,
      int isCompleted = 0,
      int isFavourite = 0,
      required String uniqueName,
      required String audioPath})
      : super(
          id: id,
          title: title,
          date: date,
          description: description,
          startTime: startTime,
          endTime: endTime,
          reminder: reminder,
          repeat: repeat,
          color: color,
          isCompleted: isCompleted,
          isFavourite: isFavourite,
          uniqueName: uniqueName,
          audioPath: audioPath,
        );

  TaskModel copyWith(
          {int? id,
          String? title,
          String? description,
          String? date,
          String? startTime,
          String? endTime,
          int? reminder,
          int? repeat,
          int? color,
          int? isCompleted,
          int? isFavourite,
          String? uniqueName,
          String? audioPath}) =>
      TaskModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        reminder: reminder ?? this.reminder,
        repeat: repeat ?? this.repeat,
        color: color ?? this.color,
        isCompleted: isCompleted ?? this.isCompleted,
        isFavourite: isFavourite ?? this.isFavourite,
        uniqueName: uniqueName ?? this.uniqueName,
        audioPath: audioPath ?? this.audioPath,
      );

  static List<TaskModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
    List<TaskModel> tasks = [];
    for (var json in jsonList) {
      tasks.add(TaskModel.fromJson(json));
    }
    return tasks;
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json[taskColumnId] as int?,
      title: json[taskColumnTitle] as String,
      date: json[taskColumnDate] as String,
      description: json[taskColumnDesc] as String,
      startTime: json[taskColumnStartTime] as String,
      endTime: json[taskColumnEndTime] as String,
      repeat: json[taskColumnRepeat] as int,
      reminder: json[taskColumnReminder] as int,
      color: json[taskColumnColor] as int,
      isCompleted: json[taskColumnIsCompleted] as int,
      isFavourite: json[taskColumnIsFavourite] as int,
      uniqueName: json[taskColumnUniqueName] as String,
      audioPath: json[taskColumnAudioPath] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        taskColumnId: id,
        taskColumnTitle: title,
        taskColumnDate: date,
        taskColumnDesc: description,
        taskColumnStartTime: startTime,
        taskColumnEndTime: endTime,
        taskColumnRepeat: repeat,
        taskColumnReminder: reminder,
        taskColumnColor: color,
        taskColumnIsCompleted: isCompleted,
        taskColumnIsFavourite: isFavourite,
        taskColumnUniqueName: uniqueName,
        taskColumnAudioPath: audioPath,
      };
}
