import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/core/constants/create_task_screen_consts.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/domain/use_cases/query_single_task.dart';
import 'package:uuid/uuid.dart';

part 'create_task_event.dart';

part 'create_task_state.dart';

enum CreateTaskUpdate {
  selectedDate,
  selectedStartTime,
  selectedEndTime,
  selectedReminder,
  selectedRepeat,
  selectedColor,
  selectedAudioPath,
}

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  final GetQuerySingleTask getQuerySingleTask;
  TextEditingController? titleController;
  TextEditingController? descriptionController;
  late String selectedDate;
  late String selectedStartTime;
  late String selectedEndTime;
  late int selectedReminder;
  late int selectedRepeat;
  late int selectedColor;
  late String selectedAudioPath;

  CreateTaskBloc({
    required this.getQuerySingleTask,
  }) : super(CreateTaskInitialState()) {
    on<InitializeCreateTask>(_onInitializeCreateTask);
    on<UpdateCreateTask>(_onUpdateCreateTask);
    on<CreateTask>(_onCreateTask);
    selectedDate = '';
    selectedStartTime = '';
    selectedEndTime = '';
    selectedRepeat = 0;
    selectedReminder = 0;
    selectedColor = 0;
    selectedAudioPath = '';
  }

  static CreateTaskBloc get(BuildContext context) => BlocProvider.of(context);

  _updateState(Emitter<CreateTaskState> emitter, CreateTaskState state) async {
    await Future.delayed(const Duration(milliseconds: 100));
    emitter(state);
  }

  Future _onInitializeCreateTask(
    InitializeCreateTask event,
    Emitter<CreateTaskState> emitter,
  ) async {
    await _updateState(emitter, CreateTaskInitializingState());
    try {
      titleController = TextEditingController();
      descriptionController = TextEditingController();
      selectedDate = DateFormat.yMd().format(DateTime.now());
      selectedStartTime = DateFormat('hh:mm aa').format(DateTime.now());
      selectedEndTime = DateFormat('hh:mm aa').format(
        DateTime.now().add(
          const Duration(
            minutes: 30,
          ),
        ),
      );
      selectedReminder = 0;
      selectedRepeat = 0;
      selectedColor = 0;
      await _updateState(emitter, CreateTaskInitializedState());
    } catch (e) {
      await _updateState(
        emitter,
        CreateTaskInitializingErrorState(
          errMessage: createTaskInitializingErrMsg,
        ),
      );
    }
  }

  Future _onUpdateCreateTask(
    UpdateCreateTask event,
    Emitter<CreateTaskState> emitter,
  ) async {
    await _updateState(emitter, CreateTaskUpdatingState());
    switch (event.createTaskUpdate) {
      case CreateTaskUpdate.selectedDate:
        await _updateSelectedDate(event.selectedDate, emitter);
        break;
      case CreateTaskUpdate.selectedStartTime:
        await _updateSelectedStartTime(event.selectedStartTime, emitter);
        break;
      case CreateTaskUpdate.selectedEndTime:
        await _updateSelectedEndTime(event.selectedEndTime, emitter);
        break;
      case CreateTaskUpdate.selectedReminder:
        await _updateSelectedReminder(event.selectedReminder, emitter);
        break;
      case CreateTaskUpdate.selectedRepeat:
        await _updateSelectedRepeat(event.selectedRepeat, emitter);
        break;
      case CreateTaskUpdate.selectedColor:
        await _updateSelectedColor(event.selectedColor, emitter);
        break;
      case CreateTaskUpdate.selectedAudioPath:
        await _updateSelectedAudioPath(event.selectedAudioPath, emitter);
        break;
    }
  }

  _updateSelectedDate(DateTime? date, Emitter<CreateTaskState> emitter) async {
    if (date != null) {
      selectedDate = DateFormat.yMd().format(date);
      await _updateState(
        emitter,
        CreateTaskUpdatedState(),
      );
    } else {
      await _updateState(
        emitter,
        CreateTaskUpdatingErrorState(
          errMessage: updateSelectedDateErrMsg,
        ),
      );
    }
  }

  _updateSelectedStartTime(
      TimeOfDay? time, Emitter<CreateTaskState> emitter) async {
    if (time != null) {
      selectedStartTime = DateFormat('hh:mm aa').format(
        DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          time.hour,
          time.minute,
        ),
      );
      selectedEndTime = DateFormat('hh:mm aa').format(
        DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          time.hour,
          time.minute,
        ).add(
          const Duration(
            minutes: 30,
          ),
        ),
      );
      await _updateState(
        emitter,
        CreateTaskUpdatedState(),
      );
    } else {
      await _updateState(
        emitter,
        CreateTaskUpdatingErrorState(
          errMessage: updateSelectedStartTimeErrMsg,
        ),
      );
    }
  }

  _updateSelectedEndTime(
      TimeOfDay? time, Emitter<CreateTaskState> emitter) async {
    if (time != null) {
      selectedEndTime = DateFormat('hh:mm aa').format(
        DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          time.hour,
          time.minute,
        ),
      );
      await _updateState(
        emitter,
        CreateTaskUpdatedState(),
      );
    } else {
      await _updateState(
        emitter,
        CreateTaskUpdatingErrorState(
          errMessage: updateSelectedEndTimeErrMsg,
        ),
      );
    }
  }

  _updateSelectedReminder(
      int? reminder, Emitter<CreateTaskState> emitter) async {
    if (reminder != null) {
      selectedReminder = reminder;
      await _updateState(
        emitter,
        CreateTaskUpdatedState(),
      );
    } else {
      await _updateState(
        emitter,
        CreateTaskUpdatingErrorState(
          errMessage: updateSelectedReminderErrMsg,
        ),
      );
    }
  }

  _updateSelectedRepeat(int? repeat, Emitter<CreateTaskState> emitter) async {
    if (repeat != null) {
      selectedRepeat = repeat;
      await _updateState(
        emitter,
        CreateTaskUpdatedState(),
      );
    } else {
      await _updateState(
        emitter,
        CreateTaskUpdatingErrorState(
          errMessage: updateSelectedRepeatErrMsg,
        ),
      );
    }
  }

  _updateSelectedColor(int? color, Emitter<CreateTaskState> emitter) async {
    if (color != null) {
      selectedColor = color;
      await _updateState(
        emitter,
        CreateTaskUpdatedState(),
      );
    } else {
      await _updateState(
        emitter,
        CreateTaskUpdatingErrorState(
          errMessage: updateSelectedColorErrMsg,
        ),
      );
    }
  }

  _updateSelectedAudioPath(
      String? selectedAudioPathPar, Emitter<CreateTaskState> emitter) async {
    if (selectedAudioPathPar != null) {
      selectedAudioPath = selectedAudioPathPar;
      await _updateState(
        emitter,
        CreateTaskUpdatedState(),
      );
    } else {
      await _updateState(
        emitter,
        CreateTaskUpdatingErrorState(
          errMessage: updateSelectedAudioPathErrMsg,
        ),
      );
    }
  }

  Future _onCreateTask(
    CreateTask event,
    Emitter<CreateTaskState> emitter,
  ) async {
    await _updateState(emitter, TaskCreatingState());
    if (titleController!.text.isEmpty) {
      await _updateState(
        emitter,
        TaskCreatingErrorState(
          errMessage: createTaskEmptyTitleErrMsg,
        ),
      );
    } else {
      TaskModel task = TaskModel(
        title: titleController!.text,
        description: descriptionController!.text,
        date: selectedDate,
        startTime: selectedStartTime,
        endTime: selectedEndTime,
        uniqueName: const Uuid().v4(),
        repeat: selectedRepeat,
        reminder: selectedReminder,
        color: selectedColor,
        audioPath: selectedAudioPath,
      );
      final result = await getQuerySingleTask.call(
        QuerySingleTaskParams(
          querySingleTask: QuerySingleTask.createTask,
          task: task,
        ),
      );
      await result.fold(
        (create) async {
          await create.fold(
            (failure) async {
              await _updateState(
                emitter,
                TaskCreatingErrorState(
                  errMessage: failure.message,
                ),
              );
            },
            (task) async {
              await _updateState(
                emitter,
                TaskCreatedState(
                  task: task,
                ),
              );
            },
          );
        },
        (delete) async {},
      );
    }
  }
}
