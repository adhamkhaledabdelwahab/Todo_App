import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/core/database/database_fetch_params.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/domain/use_cases/fetch_tasks.dart';

part 'scheduled_tasks_event.dart';

part 'scheduled_tasks_state.dart';

class ScheduledTasksBloc
    extends Bloc<ScheduledTasksEvent, ScheduledTasksState> {
  final GetFetchTasks getFetchTasks;
  List<TaskModel> allTasks = [];
  List<DateTime> datePickerDates = [];
  List<TaskModel> selectedDateTasks = [];
  DateTime? selectedDate;
  final int _startDate = DateTime.now().year;
  final int _endDate = DateTime.now().year + 20;
  final _changeSelectedDateErrMsg = 'Change selected date fails!';

  static ScheduledTasksBloc get(BuildContext context) =>
      BlocProvider.of<ScheduledTasksBloc>(context);

  _updateState(
      Emitter<ScheduledTasksState> emitter, ScheduledTasksState state) async {
    await Future.delayed(const Duration(milliseconds: 100));
    emitter(state);
  }

  ScheduledTasksBloc({required this.getFetchTasks})
      : super(ScheduledTasksInitialState()) {
    on<ScheduledTasksInitialize>(_onInitialize);
    on<ScheduledTasksUpdateSelectedDate>(_onUpdateSelectedDate);
  }

  Future _onInitialize(ScheduledTasksInitialize event,
      Emitter<ScheduledTasksState> emitter) async {
    await _updateState(emitter, ScheduledTasksInitializingState());
    final result = await getFetchTasks.call(
      const FetchTasksParams(
        fetchTasks: FetchTasks.all,
        databaseFetchParams: DatabaseFetchParams(),
      ),
    );
    await result.fold(
      (failure) async {
        await _updateState(
          emitter,
          ScheduledTasksInitializingErrorState(
            errMessage: failure.message,
          ),
        );
      },
      (tasks) async {
        allTasks.addAll(tasks);
      },
    );

    _fetchingDatePickerDates();
    selectedDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    _fetchingSelectedDateTasks();
    await _updateState(
      emitter,
      ScheduledTasksInitializedState(),
    );
  }

  Future _onUpdateSelectedDate(ScheduledTasksUpdateSelectedDate event,
      Emitter<ScheduledTasksState> emitter) async {
    await _updateState(emitter, ScheduledTasksSelectedDateUpdatingState());
    try {
      selectedDate = event.selectedDate;
      _fetchingSelectedDateTasks();
      await _updateState(emitter, ScheduledTasksSelectedDateUpdatedState());
    } catch (e) {
      await _updateState(
        emitter,
        ScheduledTasksSelectedDateUpdatingErrorState(
          errMessage: _changeSelectedDateErrMsg,
        ),
      );
    }
  }

  _fetchingSelectedDateTasks() {
    selectedDateTasks.clear();
    for (TaskModel task in allTasks) {
      if (DateFormat.yMd().parse(task.date).compareTo(selectedDate!) == 0 ||
          (task.repeat == 1) ||
          (task.repeat == 2 &&
              selectedDate!
                          .difference(DateFormat.yMd().parse(task.date))
                          .inDays %
                      7 ==
                  0) ||
          task.repeat == 3 &&
              selectedDate!.day == DateFormat.yMd().parse(task.date).day) {
        selectedDateTasks.add(task);
      }
    }
  }

  _fetchingDatePickerDates() {
    for (int year = _startDate; year <= _endDate; year++) {
      for (int month = DateTime.now().month; month <= 12; month++) {
        DateTime dateTime1 = DateTime(year, month, 1);
        DateTime dateTime2 = DateTime(year, month + 1, 1);
        int inDays =
            month + 1 == 13 ? 31 : dateTime2.difference(dateTime1).inDays;
        for (int day = DateTime.now().day; day <= inDays; day++) {
          datePickerDates.add(DateTime(year, month, day));
        }
      }
    }
  }

  String fetchingSelectedDateWeekDay(int weekDay) {
    switch (weekDay) {
      case DateTime.sunday:
        return 'Sunday';
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      default:
        return 'Saturday';
    }
  }

  String getMonthAbbr(int month) {
    switch (month) {
      case DateTime.february:
        return 'Feb';
      case DateTime.march:
        return 'Mar';
      case DateTime.april:
        return 'Apr';
      case DateTime.may:
        return 'May';
      case DateTime.june:
        return 'Jun';
      case DateTime.july:
        return 'Jul';
      case DateTime.august:
        return 'Aug';
      case DateTime.september:
        return 'Sept';
      case DateTime.october:
        return 'Oct';
      case DateTime.november:
        return 'Nov';
      case DateTime.december:
        return 'Dec';
      default:
        return 'Jan';
    }
  }

  String getDayAbbr(int day) {
    switch (day) {
      case DateTime.sunday:
        return 'Sun';
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      default:
        return 'Sat';
    }
  }
}
