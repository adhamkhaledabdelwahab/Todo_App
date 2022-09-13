// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:todo_app/src/core/constants/task_model_const.dart';
import 'package:todo_app/src/data/models/task_model.dart';

tz.TZDateTime fetchScheduledExactTime(TaskModel taskModel) {
  final hour = DateFormat('hh:mm aa').parse(taskModel.startTime).hour;
  final minutes = DateFormat('hh:mm aa').parse(taskModel.startTime).minute;
  final remind = getReminder(taskModel.reminder);
  final repeat = getRepeat(taskModel.repeat);
  final date = taskModel.date;
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  var formattedDate = DateFormat.yMd().parse(date);
  var fd = tz.TZDateTime.from(formattedDate, tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, fd.year, fd.month, fd.day, hour, minutes);
  scheduledDate = _afterRemind(remind, scheduledDate);
  if (scheduledDate.isBefore(now)) {
    if (repeat == getRepeat(1)) {
      scheduledDate = tz.TZDateTime(tz.local, fd.year, fd.month,
          fd.day + (now.difference(scheduledDate).inDays + 1), hour, minutes);
    } else if (repeat == getRepeat(2)) {
      scheduledDate = tz.TZDateTime(tz.local, fd.year, fd.month,
          fd.day + (now.difference(scheduledDate).inDays + 7), hour, minutes);
    } else if (repeat == getRepeat(3)) {
      scheduledDate =
          tz.TZDateTime(tz.local, fd.year, fd.month + 1, fd.day, hour, minutes);
    }
    scheduledDate = _afterRemind(remind, scheduledDate);
  }
  debugPrint(scheduledDate.toString());
  return scheduledDate;
}

tz.TZDateTime _afterRemind(String remind, tz.TZDateTime scheduledDate) {
  if (remind == getReminder(1)) {
    return scheduledDate.subtract(const Duration(minutes: 10));
  } else if (remind == getReminder(2)) {
    return scheduledDate.subtract(const Duration(minutes: 30));
  } else if (remind == getReminder(3)) {
    return scheduledDate.subtract(const Duration(hours: 1));
  } else if (remind == getReminder(4)) {
    return scheduledDate.subtract(const Duration(days: 1));
  } else {
    return scheduledDate;
  }
}
