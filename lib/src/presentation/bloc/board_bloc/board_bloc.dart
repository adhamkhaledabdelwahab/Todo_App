import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/core/constants/board_screen_consts.dart';
import 'package:todo_app/src/core/database/database_fetch_params.dart';
import 'package:todo_app/src/core/use_cases/use_cases.dart';
import 'package:todo_app/src/core/utils/list_extension.dart';
import 'package:todo_app/src/data/models/notification_model.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/domain/use_cases/use_cases.dart';

part 'board_event.dart';

part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final GetFetchNotifications getFetchNotifications;
  final GetFetchTasks getFetchTasks;
  final GetQueryAllNotifications getQueryAllNotifications;
  final GetQueryAllTasks getQueryAllTasks;
  final GetQuerySelectedTasks getQuerySelectedTasks;
  final GetQuerySingleNotification getQuerySingleNotification;
  final GetQuerySingleTask getQuerySingleTask;
  final List<TaskModel> allTasks = [];
  final List<TaskModel> completedTasks = [];
  final List<TaskModel> unCompletedTasks = [];
  final List<TaskModel> favouriteTasks = [];
  final List<TaskModel> selectedTasksAll = [];
  final List<TaskModel> selectedTasksCompleted = [];
  final List<TaskModel> selectedTasksUnCompleted = [];
  final List<TaskModel> selectedTasksFavourite = [];
  final List<NotificationModel> allNotifications = [];

  BoardBloc({
    required this.getFetchNotifications,
    required this.getFetchTasks,
    required this.getQueryAllNotifications,
    required this.getQueryAllTasks,
    required this.getQuerySelectedTasks,
    required this.getQuerySingleNotification,
    required this.getQuerySingleTask,
  }) : super(BoardInitialState()) {
    on<BoardFetchAllNotifications>(_onFetchAllNotifications);
    on<BoardFetchAllTasks>(_onFetchAllTasks);
    on<BoardFetchCompletedTasks>(_onFetchCompletedTasks);
    on<BoardFetchUnCompletedTasks>(_onFetchUnCompletedTasks);
    on<BoardFetchFavouriteTasks>(_onFetchFavouriteTasks);

    on<BoardDeleteAllTasks>(_onDeleteAllTasks);
    on<BoardMarkAllTasksAsCompleted>(_onMarkAllTasksAsCompleted);
    on<BoardMarkAllTasksAsUnCompleted>(_onMarkAllTasksAsUnCompleted);
    on<BoardMarkAllTasksAsFavourite>(_onMarkAllTasksAsFavourite);
    on<BoardMarkAllTasksAsUnFavourite>(_onMarkAllTasksAsUnFavourite);

    on<BoardDeleteSelectedTasks>(_onDeleteSelectedTasks);
    on<BoardMarkSelectedTasksAsCompleted>(_onMarkSelectedTasksAsCompleted);
    on<BoardMarkSelectedTasksAsUnCompleted>(_onMarkSelectedTasksAsUnCompleted);
    on<BoardMarkSelectedTasksAsFavourite>(_oMarkSelectedTasksAsFavourite);
    on<BoardMarkSelectedTasksAsUnFavourite>(_onMarkSelectedTasksAsUnFavourite);

    on<BoardDeleteSingleNotification>(_onDeleteSingleNotification);
    on<BoardMarkSingleNotificationAsRead>(_onMarkSingleNotificationAsRead);
    on<BoardMarkSingleNotificationAsUnRead>(_onMarkSingleNotificationAsUnRead);
    on<BoardMarkAllNotificationsAsRead>(_onMarkAllNotificationsAsRead);

    on<BoardDeleteSingleTask>(_onDeleteSingleTask);
    on<BoardMarkSingleTaskAsCompleted>(_onMarkSingleTaskAsCompleted);
    on<BoardMarkSingleTaskAsUnCompleted>(_onMarkSingleTaskAsUnCompleted);
    on<BoardMarkSingleTaskAsFavourite>(_onMarkSingleTaskAsFavourite);
    on<BoardMarkSingleTaskAsUnFavourite>(_onMarkSingleTaskAsUnFavourite);

    on<BoardUpdateTasksAfterCreate>(_onBoardUpdateTasksAfterCreate);

    on<BoardUpdateSelectedTasks>(_onBoardUpdateSelectedTasks);

    boardNotificationUpdateReceivePort.listen((_) {
      add(BoardFetchAllNotifications());
      debugPrint('notification update port listener invoked');
    });
  }

  static BoardBloc get(BuildContext context) => BlocProvider.of(context);

  _updateState(Emitter<BoardState> emitter, BoardState state) async {
    await Future.delayed(const Duration(milliseconds: 100));
    emitter(state);
  }

  Future _onFetchAllNotifications(
    BoardFetchAllNotifications event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardAllNotificationsFetchingState());
    final result = await getFetchNotifications.call(
      const DatabaseFetchParams(),
    );
    await result.fold(
      (failure) async {
        await _updateState(
          emitter,
          BoardAllNotificationsFetchingErrorState(errMessage: failure.message),
        );
      },
      (notifications) async {
        allNotifications.clear();
        allNotifications.addAll(notifications);
        await _updateState(emitter, BoardAllNotificationsFetchedState());
      },
    );
  }

  Future _onFetchAllTasks(
    BoardFetchAllTasks event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardAllTasksFetchingState());
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
          BoardAllTasksFetchingErrorState(errMessage: failure.message),
        );
      },
      (tasks) async {
        allTasks.clear();
        allTasks.addAll(tasks);
        await _updateState(emitter, BoardAllTasksFetchedState());
      },
    );
  }

  Future _onFetchCompletedTasks(
    BoardFetchCompletedTasks event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardCompletedTasksFetchingState());
    final result = await getFetchTasks.call(
      const FetchTasksParams(
        fetchTasks: FetchTasks.completed,
        databaseFetchParams: DatabaseFetchParams(),
      ),
    );
    await result.fold(
      (failure) async {
        await _updateState(
          emitter,
          BoardCompletedTasksFetchingErrorState(errMessage: failure.message),
        );
      },
      (tasks) async {
        completedTasks.clear();
        completedTasks.addAll(tasks);
        await _updateState(emitter, BoardCompletedTasksFetchedState());
      },
    );
  }

  Future _onFetchUnCompletedTasks(
    BoardFetchUnCompletedTasks event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardUnCompletedTasksFetchingState());
    final result = await getFetchTasks.call(
      const FetchTasksParams(
        fetchTasks: FetchTasks.uncompleted,
        databaseFetchParams: DatabaseFetchParams(),
      ),
    );
    await result.fold(
      (failure) async {
        await _updateState(
          emitter,
          BoardUnCompletedTasksFetchingErrorState(errMessage: failure.message),
        );
      },
      (tasks) async {
        unCompletedTasks.clear();
        unCompletedTasks.addAll(tasks);
        await _updateState(emitter, BoardUnCompletedTasksFetchedState());
      },
    );
  }

  Future _onFetchFavouriteTasks(
    BoardFetchFavouriteTasks event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardFavouriteTasksFetchingState());
    final result = await getFetchTasks.call(
      const FetchTasksParams(
        fetchTasks: FetchTasks.favourite,
        databaseFetchParams: DatabaseFetchParams(),
      ),
    );
    await result.fold(
      (failure) async {
        await _updateState(
          emitter,
          BoardFavouriteTasksFetchingErrorState(errMessage: failure.message),
        );
      },
      (tasks) async {
        favouriteTasks.clear();
        favouriteTasks.addAll(tasks);
        await _updateState(emitter, BoardFavouriteTasksFetchedState());
      },
    );
  }

  Future _onDeleteAllTasks(
    BoardDeleteAllTasks event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(
      emitter,
      BoardAllTasksDeletingState(),
    );
    final result = await getQueryAllTasks.call(
      const QueryAllTasksParams(
        queryAllTasks: QueryAllTasks.deleteAllTasks,
      ),
    );
    await result.fold(
      (failure) async {
        await _updateState(
          emitter,
          BoardAllTasksDeletingErrorState(errMessage: failure.message),
        );
      },
      (voidR) async {
        _updateUIAfterDeleteAllTasks();
        await _updateState(
          emitter,
          BoardAllTasksDeletedState(),
        );
      },
    );
  }

  _updateUIAfterDeleteAllTasks() {
    allTasks.clear();
    completedTasks.clear();
    unCompletedTasks.clear();
    favouriteTasks.clear();
    allNotifications.clear();
  }

  Future _onMarkAllTasksAsCompleted(
    BoardMarkAllTasksAsCompleted event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardAllTasksCompletedMarkingState());
    final result = await getQueryAllTasks.call(
      const QueryAllTasksParams(
        queryAllTasks: QueryAllTasks.markAllTasksAsCompleted,
      ),
    );
    await result.fold(
      (failure) async {
        await _updateState(
          emitter,
          BoardAllTasksCompletedMarkingErrorState(
            errMessage: failure.message,
          ),
        );
      },
      (voidR) async {
        _updateUIAfterMarkAllTasksCompleted();
        await _updateState(emitter, BoardAllTasksCompletedMarkedState());
      },
    );
  }

  _updateUIAfterMarkAllTasksCompleted() {
    for (int i = 0; i < unCompletedTasks.length; i++) {
      unCompletedTasks[i] = unCompletedTasks[i].copyWith(isCompleted: 1);
    }
    completedTasks.addAll(unCompletedTasks);
    unCompletedTasks.clear();
    for (int k = 0; k < allTasks.length; k++) {
      allTasks[k] = allTasks[k].copyWith(
        isCompleted: 1,
      );
    }
    for (int j = 0; j < favouriteTasks.length; j++) {
      favouriteTasks[j] = favouriteTasks[j].copyWith(
        isCompleted: 1,
      );
    }
  }

  Future _onMarkAllTasksAsUnCompleted(
    BoardMarkAllTasksAsUnCompleted event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardAllTasksUnCompletedMarkingState());
    final result = await getQueryAllTasks.call(
      const QueryAllTasksParams(
        queryAllTasks: QueryAllTasks.markAllTasksAsUnCompleted,
      ),
    );
    await result.fold(
      (failure) async {
        await _updateState(
            emitter,
            BoardAllTasksUnCompletedMarkingErrorState(
                errMessage: failure.message));
      },
      (voidR) async {
        _updateUIAfterMarkAllTasksUnCompleted();
        await _updateState(emitter, BoardAllTasksUnCompletedMarkedState());
      },
    );
  }

  _updateUIAfterMarkAllTasksUnCompleted() {
    for (int i = 0; i < completedTasks.length; i++) {
      completedTasks[i] = completedTasks[i].copyWith(isCompleted: 0);
    }
    unCompletedTasks.addAll(completedTasks);
    completedTasks.clear();
    for (int k = 0; k < allTasks.length; k++) {
      allTasks[k] = allTasks[k].copyWith(
        isCompleted: 0,
      );
    }
    for (int j = 0; j < favouriteTasks.length; j++) {
      favouriteTasks[j] = favouriteTasks[j].copyWith(
        isCompleted: 0,
      );
    }
  }

  Future _onMarkAllTasksAsFavourite(
    BoardMarkAllTasksAsFavourite event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardAllTasksFavouriteMarkingState());
    final result = await getQueryAllTasks.call(
      const QueryAllTasksParams(
          queryAllTasks: QueryAllTasks.markAllTasksAsFavourite),
    );
    await result.fold(
      (failure) async {
        await _updateState(
          emitter,
          BoardAllTasksFavouriteMarkingErrorState(
            errMessage: failure.message,
          ),
        );
      },
      (voidR) async {
        _updateUIAfterMarkAllTasksFavourite();
        await _updateState(emitter, BoardAllTasksFavouriteMarkedState());
      },
    );
  }

  _updateUIAfterMarkAllTasksFavourite() {
    for (int k = 0; k < allTasks.length; k++) {
      allTasks[k] = allTasks[k].copyWith(
        isFavourite: 1,
      );
    }
    for (int i = 0; i < completedTasks.length; i++) {
      completedTasks[i] = completedTasks[i].copyWith(
        isFavourite: 1,
      );
    }
    for (int j = 0; j < unCompletedTasks.length; j++) {
      unCompletedTasks[j] = unCompletedTasks[j].copyWith(
        isFavourite: 1,
      );
    }
    favouriteTasks.clear();
    favouriteTasks.addAll(allTasks);
  }

  Future _onMarkAllTasksAsUnFavourite(
    BoardMarkAllTasksAsUnFavourite event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardAllTasksUnFavouriteMarkingState());
    final result = await getQueryAllTasks.call(
      const QueryAllTasksParams(
        queryAllTasks: QueryAllTasks.markAllTasksAsUnFavourite,
      ),
    );
    await result.fold(
      (failure) async {
        await _updateState(
          emitter,
          BoardAllTasksUnFavouriteMarkingErrorState(
            errMessage: failure.message,
          ),
        );
      },
      (voidR) async {
        _updateUIAfterMarkAllTasksUnFavourite();
        await _updateState(emitter, BoardAllTasksUnFavouriteMarkedState());
      },
    );
  }

  void _updateUIAfterMarkAllTasksUnFavourite() {
    favouriteTasks.clear();
    for (int k = 0; k < allTasks.length; k++) {
      allTasks[k] = allTasks[k].copyWith(
        isFavourite: 0,
      );
    }
    for (int i = 0; i < completedTasks.length; i++) {
      completedTasks[i] = completedTasks[i].copyWith(
        isFavourite: 0,
      );
    }
    for (int j = 0; j < unCompletedTasks.length; j++) {
      unCompletedTasks[j] = unCompletedTasks[j].copyWith(
        isFavourite: 0,
      );
    }
  }

  Future _onDeleteSelectedTasks(
      BoardDeleteSelectedTasks event, Emitter<BoardState> emitter) async {
    await _updateState(emitter, BoardSelectedTasksDeletingState());
    final result = await getQuerySelectedTasks.call(
      QuerySelectedTasksParams(
        querySelectedTasks: QuerySelectedTasks.deleteSelectedTasks,
        tasks: event.tasks,
      ),
    );
    await result.fold(
      (update) async {},
      (delete) async {
        delete.fold(
          (failure) async {
            await _updateState(
              emitter,
              BoardSelectedTasksDeletingErrorState(
                errMessage: failure.message,
              ),
            );
          },
          (voidR) async {
            _updateUIAfterDeleteSelected(event.tasks);
            await _updateState(emitter, BoardSelectedTasksDeletedState());
          },
        );
      },
    );
  }

  _updateUIAfterDeleteSelected(List<TaskModel> selectedTasks) {
    for (int i = 0; i < selectedTasks.length; i++) {
      allTasks.removeWhere((element) => element == selectedTasks[i]);
      completedTasks.removeWhere((element) => element == selectedTasks[i]);
      unCompletedTasks.removeWhere((element) => element == selectedTasks[i]);
      favouriteTasks.removeWhere((element) => element == selectedTasks[i]);
      allNotifications.removeWhere(
          (element) => element.taskUniqueName == selectedTasks[i].uniqueName);
    }
    selectedTasks.clear();
  }

  Future _onMarkSelectedTasksAsCompleted(
      BoardMarkSelectedTasksAsCompleted event,
      Emitter<BoardState> emitter) async {
    await _updateState(emitter, BoardSelectedTasksCompletedMarkingState());
    final result = await getQuerySelectedTasks.call(
      QuerySelectedTasksParams(
        querySelectedTasks: QuerySelectedTasks.markSelectedTasksAsCompleted,
        tasks: event.tasks,
      ),
    );
    await result.fold(
      (update) async {
        await update.fold(
          (failure) async {
            await _updateState(
              emitter,
              BoardSelectedTasksCompletedMarkingErrorState(
                errMessage: failure.message,
              ),
            );
          },
          (tasks) async {
            _updateUIAfterSelectedTasksCompleted(tasks, event.tasks);
            await _updateState(
                emitter, BoardSelectedTasksCompletedMarkedState());
          },
        );
      },
      (delete) async {},
    );
  }

  _updateUIAfterSelectedTasksCompleted(
      List<TaskModel> newTasks, List<TaskModel> selectedTasks) {
    for (int i = 0; i < selectedTasks.length; i++) {
      unCompletedTasks.removeWhere((element) => element == selectedTasks[i]);
      completedTasks.add(newTasks[i]);
      allTasks.replaceIfExists(newTasks[i], selectedTasks[i]);
      favouriteTasks.replaceIfExists(newTasks[i], selectedTasks[i]);
    }
    selectedTasks.clear();
  }

  Future _onMarkSelectedTasksAsUnCompleted(
      BoardMarkSelectedTasksAsUnCompleted event,
      Emitter<BoardState> emitter) async {
    await _updateState(emitter, BoardSelectedTasksUnCompletedMarkingState());
    final result = await getQuerySelectedTasks.call(
      QuerySelectedTasksParams(
        querySelectedTasks: QuerySelectedTasks.markSelectedTasksAsUnCompleted,
        tasks: event.tasks,
      ),
    );
    await result.fold(
      (update) async {
        await update.fold(
          (failure) async {
            await _updateState(
              emitter,
              BoardSelectedTasksUnCompletedMarkingErrorState(
                errMessage: failure.message,
              ),
            );
          },
          (tasks) async {
            _updateUIAfterSelectedTasksUnCompleted(tasks, event.tasks);
            await _updateState(
                emitter, BoardSelectedTasksUnCompletedMarkedState());
          },
        );
      },
      (delete) async {},
    );
  }

  _updateUIAfterSelectedTasksUnCompleted(
      List<TaskModel> newTasks, List<TaskModel> selectedTasks) {
    for (int i = 0; i < selectedTasks.length; i++) {
      completedTasks.removeWhere((element) => element == selectedTasks[i]);
      unCompletedTasks.add(newTasks[i]);
      allTasks.replaceIfExists(newTasks[i], selectedTasks[i]);
      favouriteTasks.replaceIfExists(newTasks[i], selectedTasks[i]);
    }
    selectedTasks.clear();
  }

  Future _oMarkSelectedTasksAsFavourite(BoardMarkSelectedTasksAsFavourite event,
      Emitter<BoardState> emitter) async {
    await _updateState(emitter, BoardSelectedTasksFavouriteMarkingState());
    final result = await getQuerySelectedTasks.call(
      QuerySelectedTasksParams(
        querySelectedTasks: QuerySelectedTasks.markSelectedTasksAsFavourite,
        tasks: event.tasks,
      ),
    );
    await result.fold(
      (update) async {
        await update.fold(
          (failure) async {
            await _updateState(
              emitter,
              BoardSelectedTasksFavouriteMarkingErrorState(
                errMessage: failure.message,
              ),
            );
          },
          (tasks) async {
            _updateUIAfterSelectedTasksFavourite(tasks, event.tasks);
            await _updateState(
                emitter, BoardSelectedTasksFavouriteMarkedState());
          },
        );
      },
      (delete) async {},
    );
  }

  _updateUIAfterSelectedTasksFavourite(
      List<TaskModel> newTasks, List<TaskModel> selectedTasks) {
    for (int i = 0; i < selectedTasks.length; i++) {
      favouriteTasks.add(newTasks[i]);
      completedTasks.replaceIfExists(newTasks[i], selectedTasks[i]);
      unCompletedTasks.replaceIfExists(newTasks[i], selectedTasks[i]);
      allTasks.replaceIfExists(newTasks[i], selectedTasks[i]);
    }
    selectedTasks.clear();
  }

  Future _onMarkSelectedTasksAsUnFavourite(
      BoardMarkSelectedTasksAsUnFavourite event,
      Emitter<BoardState> emitter) async {
    await _updateState(emitter, BoardSelectedTasksUnFavouriteMarkingState());
    final result = await getQuerySelectedTasks.call(
      QuerySelectedTasksParams(
        querySelectedTasks: QuerySelectedTasks.markSelectedTasksAsUnFavourite,
        tasks: event.tasks,
      ),
    );
    await result.fold(
      (update) async {
        await update.fold(
          (failure) async {
            await _updateState(
              emitter,
              BoardSelectedTasksUnFavouriteMarkingErrorState(
                errMessage: failure.message,
              ),
            );
          },
          (tasks) async {
            _updateUIAfterSelectedTasksUnFavourite(tasks, event.tasks);
            await _updateState(
                emitter, BoardSelectedTasksUnFavouriteMarkedState());
          },
        );
      },
      (delete) async {},
    );
  }

  _updateUIAfterSelectedTasksUnFavourite(
      List<TaskModel> newTasks, List<TaskModel> selectedTasks) {
    for (int i = 0; i < selectedTasks.length; i++) {
      favouriteTasks.removeWhere((element) => element == selectedTasks[i]);
      completedTasks.replaceIfExists(newTasks[i], selectedTasks[i]);
      unCompletedTasks.replaceIfExists(newTasks[i], selectedTasks[i]);
      allTasks.replaceIfExists(newTasks[i], selectedTasks[i]);
    }
    selectedTasks.clear();
  }

  Future _onDeleteSingleNotification(
    BoardDeleteSingleNotification event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardSingleNotificationDeletingState());
    final result = await getQuerySingleNotification.call(
      QuerySingleNotificationParams(
        querySingleNotification:
            QuerySingleNotification.deleteSingleNotification,
        notification: event.notification,
      ),
    );
    await result.fold(
      (update) async {},
      (delete) async {
        await delete.fold(
          (failure) async {
            await _updateState(
              emitter,
              BoardSingleNotificationDeletingErrorState(
                errMessage: failure.message,
              ),
            );
          },
          (voidR) async {
            allNotifications
                .removeWhere((element) => element == event.notification);
            await _updateState(emitter, BoardSingleNotificationDeletedState());
          },
        );
      },
    );
  }

  Future _onMarkSingleNotificationAsRead(
    BoardMarkSingleNotificationAsRead event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardSingleNotificationReadMarkingState());
    final result = await getQuerySingleNotification.call(
      QuerySingleNotificationParams(
        querySingleNotification:
            QuerySingleNotification.markSingleNotificationAsRead,
        notification: event.notification,
      ),
    );
    await result.fold(
      (update) async {
        await update.fold(
          (failure) async {
            await _updateState(
              emitter,
              BoardSingleNotificationReadMarkingErrorState(
                errMessage: failure.message,
              ),
            );
          },
          (notification) async {
            allNotifications.replaceIfExists(notification, event.notification);
            await _updateState(
                emitter, BoardSingleNotificationReadMarkedState());
          },
        );
      },
      (delete) async {},
    );
  }

  Future _onMarkSingleNotificationAsUnRead(
    BoardMarkSingleNotificationAsUnRead event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardSingleNotificationUnReadMarkingState());
    final result = await getQuerySingleNotification.call(
      QuerySingleNotificationParams(
        querySingleNotification:
            QuerySingleNotification.markSingleNotificationAsUnRead,
        notification: event.notification,
      ),
    );
    await result.fold(
      (update) async {
        await update.fold(
          (failure) async {
            await _updateState(
              emitter,
              BoardSingleNotificationUnReadMarkingErrorState(
                errMessage: failure.message,
              ),
            );
          },
          (notification) async {
            allNotifications.replaceIfExists(notification, event.notification);
            await _updateState(
                emitter, BoardSingleNotificationUnReadMarkedState());
          },
        );
      },
      (delete) async {},
    );
  }

  Future _onMarkAllNotificationsAsRead(
    BoardMarkAllNotificationsAsRead event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardAllNotificationsReadMarkingState());
    final result = await getQueryAllNotifications.call(NoParams());
    await result.fold(
      (failure) async {
        await _updateState(
          emitter,
          BoardAllNotificationsReadMarkingErrorState(
            errMessage: failure.message,
          ),
        );
      },
      (voidR) async {
        _markAllNotificationsAsRead();
        await _updateState(emitter, BoardAllNotificationsReadMarkedState());
      },
    );
  }

  _markAllNotificationsAsRead() {
    for (int i = 0; i < allNotifications.length; i++) {
      allNotifications[i] = allNotifications[i].copyWith(isRead: 1);
    }
  }

  Future _onDeleteSingleTask(
    BoardDeleteSingleTask event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardSingleTaskDeletingState());
    final result = await getQuerySingleTask.call(
      QuerySingleTaskParams(
        querySingleTask: QuerySingleTask.deleteSingleTask,
        task: event.task,
      ),
    );
    await result.fold(
      (update) async {},
      (delete) async {
        await delete.fold(
          (failure) async {
            _updateState(
              emitter,
              BoardSingleTaskDeletingErrorState(
                errMessage: failure.message,
              ),
            );
          },
          (voidR) async {
            _updateUIAfterSingleTaskDelete(event.task);
            await _updateState(emitter, BoardSingleTaskDeletedState());
          },
        );
      },
    );
  }

  _updateUIAfterSingleTaskDelete(TaskModel taskModel) {
    allTasks.removeWhere((element) => element == taskModel);
    completedTasks.removeWhere((element) => element == taskModel);
    unCompletedTasks.removeWhere((element) => element == taskModel);
    favouriteTasks.removeWhere((element) => element == taskModel);
    allNotifications.removeWhere(
        (element) => element.taskUniqueName == taskModel.uniqueName);
  }

  Future _onMarkSingleTaskAsCompleted(
    BoardMarkSingleTaskAsCompleted event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardSingleTaskCompletedMarkingState());
    final result = await getQuerySingleTask.call(
      QuerySingleTaskParams(
        querySingleTask: QuerySingleTask.markSingleTaskAsCompleted,
        task: event.task,
      ),
    );
    await result.fold(
      (update) async {
        await update.fold(
          (failure) async {
            await _updateState(
              emitter,
              BoardSingleTaskCompletedMarkingErrorState(
                errMessage: failure.message,
              ),
            );
          },
          (task) async {
            _updateUIAfterSingleTaskCompleted(task, event.task);
            await _updateState(emitter, BoardSingleTaskCompletedMarkedState());
          },
        );
      },
      (delete) async {},
    );
  }

  _updateUIAfterSingleTaskCompleted(TaskModel newTask, TaskModel oldTask) {
    allTasks.replaceIfExists(newTask, oldTask);
    favouriteTasks.replaceIfExists(newTask, oldTask);
    unCompletedTasks.removeWhere((element) => element == oldTask);
    completedTasks.add(newTask);
  }

  Future _onMarkSingleTaskAsUnCompleted(
    BoardMarkSingleTaskAsUnCompleted event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardSingleTaskUnCompletedMarkingState());
    final result = await getQuerySingleTask.call(
      QuerySingleTaskParams(
        querySingleTask: QuerySingleTask.markSingleTaskAsUnCompleted,
        task: event.task,
      ),
    );
    await result.fold(
      (update) async {
        await update.fold(
          (failure) async {
            await _updateState(
              emitter,
              BoardSingleTaskUnCompletedMarkingErrorState(
                errMessage: failure.message,
              ),
            );
          },
          (task) async {
            _updateUIAfterSingleTaskUnCompleted(task, event.task);
            await _updateState(
                emitter, BoardSingleTaskUnCompletedMarkedState());
          },
        );
      },
      (delete) async {},
    );
  }

  _updateUIAfterSingleTaskUnCompleted(TaskModel newTask, TaskModel oldTask) {
    allTasks.replaceIfExists(newTask, oldTask);
    favouriteTasks.replaceIfExists(newTask, oldTask);
    completedTasks.removeWhere((element) => element == oldTask);
    unCompletedTasks.add(newTask);
  }

  Future _onMarkSingleTaskAsFavourite(
    BoardMarkSingleTaskAsFavourite event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardSingleTaskFavouriteMarkingState());
    final result = await getQuerySingleTask.call(
      QuerySingleTaskParams(
        querySingleTask: QuerySingleTask.markSingleTaskAsFavourite,
        task: event.task,
      ),
    );
    await result.fold(
      (update) async {
        await update.fold(
          (failure) async {
            await _updateState(
              emitter,
              BoardSingleTaskFavouriteMarkingErrorState(
                errMessage: failure.message,
              ),
            );
          },
          (task) async {
            _updateUIAfterSingleTaskFavourite(task, event.task);
            await _updateState(emitter, BoardSingleTaskFavouriteMarkedState());
          },
        );
      },
      (delete) async {},
    );
  }

  _updateUIAfterSingleTaskFavourite(TaskModel newTask, TaskModel oldTask) {
    allTasks.replaceIfExists(newTask, oldTask);
    completedTasks.replaceIfExists(newTask, oldTask);
    unCompletedTasks.replaceIfExists(newTask, oldTask);
    favouriteTasks.add(newTask);
  }

  Future _onMarkSingleTaskAsUnFavourite(
    BoardMarkSingleTaskAsUnFavourite event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardSingleTaskUnFavouriteMarkingState());
    final result = await getQuerySingleTask.call(
      QuerySingleTaskParams(
        querySingleTask: QuerySingleTask.markSingleTaskAsUnFavourite,
        task: event.task,
      ),
    );
    await result.fold(
      (update) async {
        await update.fold(
          (failure) async {
            await _updateState(
              emitter,
              BoardSingleTaskUnFavouriteMarkingErrorState(
                errMessage: failure.message,
              ),
            );
          },
          (task) async {
            _updateUIAfterSingleTaskUnFavourite(task, event.task);
            await _updateState(
                emitter, BoardSingleTaskUnFavouriteMarkedState());
          },
        );
      },
      (delete) async {},
    );
  }

  _updateUIAfterSingleTaskUnFavourite(TaskModel newTask, TaskModel oldTask) {
    favouriteTasks.removeWhere((element) => element == oldTask);
    allTasks.replaceIfExists(newTask, oldTask);
    completedTasks.replaceIfExists(newTask, oldTask);
    unCompletedTasks.replaceIfExists(newTask, oldTask);
  }

  Future _onBoardUpdateTasksAfterCreate(
    BoardUpdateTasksAfterCreate event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardAfterCreateTasksUpdatingState());
    try {
      allTasks.add(event.task);
      unCompletedTasks.add(event.task);
      await _updateState(emitter, BoardAfterCreateTasksUpdatedState());
    } catch (e) {
      await _updateState(
        emitter,
        BoardAfterCreateTasksUpdatingErrorState(
            errMessage: 'Adding created task to tasks fails!'),
      );
    }
  }

  Future _onBoardUpdateSelectedTasks(
    BoardUpdateSelectedTasks event,
    Emitter<BoardState> emitter,
  ) async {
    await _updateState(emitter, BoardSelectedTasksUIUpdatingState());
    try {
      switch (event.updateSelectedTasks) {
        case UpdateSelectedTasks.allTasks:
          event.isAdding
              ? selectedTasksAll.add(event.task)
              : selectedTasksAll.removeWhere((task) => task == event.task);
          break;
        case UpdateSelectedTasks.completedTasks:
          event.isAdding
              ? selectedTasksUnCompleted.add(event.task)
              : selectedTasksUnCompleted
                  .removeWhere((task) => task == event.task);
          break;
        case UpdateSelectedTasks.unCompletedTasks:
          event.isAdding
              ? selectedTasksUnCompleted.add(event.task)
              : selectedTasksUnCompleted
                  .removeWhere((task) => task == event.task);
          break;
        case UpdateSelectedTasks.favouriteTasks:
          event.isAdding
              ? selectedTasksFavourite.add(event.task)
              : selectedTasksFavourite
                  .removeWhere((task) => task == event.task);
          break;
      }
      await _updateState(emitter, BoardSelectedTasksUIUpdatedState());
    } catch (e) {
      await _updateState(
        emitter,
        BoardSelectedTasksUIUpdatingErrorState(
            errMessage: 'Update selected tasks fails!'),
      );
    }
  }
}

enum UpdateSelectedTasks {
  allTasks,
  completedTasks,
  unCompletedTasks,
  favouriteTasks,
}
