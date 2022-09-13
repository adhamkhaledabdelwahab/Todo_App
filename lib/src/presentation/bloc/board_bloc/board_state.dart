part of 'board_bloc.dart';

@immutable
abstract class BoardState {}

class BoardErrorState extends BoardState {
  final String errMessage;

  BoardErrorState({
    required this.errMessage,
  });
}

class BoardLoadingState extends BoardState {
  final String? loadingMessage;

  BoardLoadingState({
    this.loadingMessage,
  });
}

class BoardLoadedState extends BoardState {}

class BoardInitialState extends BoardState {}

class BoardAllNotificationsFetchingState extends BoardLoadingState {
  BoardAllNotificationsFetchingState({super.loadingMessage});
}

class BoardAllNotificationsFetchedState extends BoardLoadedState {}

class BoardAllNotificationsFetchingErrorState extends BoardErrorState {
  BoardAllNotificationsFetchingErrorState({required super.errMessage});
}

class BoardAllTasksFetchingState extends BoardLoadingState {
  BoardAllTasksFetchingState({super.loadingMessage});
}

class BoardAllTasksFetchedState extends BoardLoadedState {}

class BoardAllTasksFetchingErrorState extends BoardErrorState {
  BoardAllTasksFetchingErrorState({required super.errMessage});
}

class BoardCompletedTasksFetchingState extends BoardLoadingState {
  BoardCompletedTasksFetchingState({super.loadingMessage});
}

class BoardCompletedTasksFetchedState extends BoardLoadedState {}

class BoardCompletedTasksFetchingErrorState extends BoardErrorState {
  BoardCompletedTasksFetchingErrorState({required super.errMessage});
}

class BoardUnCompletedTasksFetchingState extends BoardLoadingState {
  BoardUnCompletedTasksFetchingState({super.loadingMessage});
}

class BoardUnCompletedTasksFetchedState extends BoardLoadedState {}

class BoardUnCompletedTasksFetchingErrorState extends BoardErrorState {
  BoardUnCompletedTasksFetchingErrorState({required super.errMessage});
}

class BoardFavouriteTasksFetchingState extends BoardLoadingState {
  BoardFavouriteTasksFetchingState({super.loadingMessage});
}

class BoardFavouriteTasksFetchedState extends BoardLoadedState {}

class BoardFavouriteTasksFetchingErrorState extends BoardErrorState {
  BoardFavouriteTasksFetchingErrorState({required super.errMessage});
}

class BoardAllTasksDeletingState extends BoardLoadingState {
  BoardAllTasksDeletingState()
      : super(
          loadingMessage: deletingAllTasksLoadingText,
        );
}

class BoardAllTasksDeletedState extends BoardLoadedState {}

class BoardAllTasksDeletingErrorState extends BoardErrorState {
  BoardAllTasksDeletingErrorState({required super.errMessage});
}

class BoardAllTasksCompletedMarkingState extends BoardLoadingState {
  BoardAllTasksCompletedMarkingState()
      : super(
          loadingMessage: markAllTasksCompletedLoadingText,
        );
}

class BoardAllTasksCompletedMarkedState extends BoardLoadedState {}

class BoardAllTasksCompletedMarkingErrorState extends BoardErrorState {
  BoardAllTasksCompletedMarkingErrorState({required super.errMessage});
}

class BoardAllTasksUnCompletedMarkingState extends BoardLoadingState {
  BoardAllTasksUnCompletedMarkingState()
      : super(
          loadingMessage: markAllTasksUnCompletedLoadingText,
        );
}

class BoardAllTasksUnCompletedMarkedState extends BoardLoadedState {}

class BoardAllTasksUnCompletedMarkingErrorState extends BoardErrorState {
  BoardAllTasksUnCompletedMarkingErrorState({required super.errMessage});
}

class BoardAllTasksFavouriteMarkingState extends BoardLoadingState {
  BoardAllTasksFavouriteMarkingState()
      : super(
          loadingMessage: markAllTasksFavouriteLoadingText,
        );
}

class BoardAllTasksFavouriteMarkedState extends BoardLoadedState {}

class BoardAllTasksFavouriteMarkingErrorState extends BoardErrorState {
  BoardAllTasksFavouriteMarkingErrorState({required super.errMessage});
}

class BoardAllTasksUnFavouriteMarkingState extends BoardLoadingState {
  BoardAllTasksUnFavouriteMarkingState()
      : super(
          loadingMessage: markAllTasksUnFavouriteLoadingText,
        );
}

class BoardAllTasksUnFavouriteMarkedState extends BoardLoadedState {}

class BoardAllTasksUnFavouriteMarkingErrorState extends BoardErrorState {
  BoardAllTasksUnFavouriteMarkingErrorState({required super.errMessage});
}

class BoardSelectedTasksDeletingState extends BoardLoadingState {
  BoardSelectedTasksDeletingState()
      : super(
          loadingMessage: deletingSelectedTasksLoadingText,
        );
}

class BoardSelectedTasksDeletedState extends BoardLoadedState {}

class BoardSelectedTasksDeletingErrorState extends BoardErrorState {
  BoardSelectedTasksDeletingErrorState({required super.errMessage});
}

class BoardSelectedTasksCompletedMarkingState extends BoardLoadingState {
  BoardSelectedTasksCompletedMarkingState()
      : super(
          loadingMessage: markSelectedTasksCompletedLoadingText,
        );
}

class BoardSelectedTasksCompletedMarkedState extends BoardLoadedState {}

class BoardSelectedTasksCompletedMarkingErrorState extends BoardErrorState {
  BoardSelectedTasksCompletedMarkingErrorState({required super.errMessage});
}

class BoardSelectedTasksUnCompletedMarkingState extends BoardLoadingState {
  BoardSelectedTasksUnCompletedMarkingState()
      : super(
          loadingMessage: markSelectedTasksUnCompletedLoadingText,
        );
}

class BoardSelectedTasksUnCompletedMarkedState extends BoardLoadedState {}

class BoardSelectedTasksUnCompletedMarkingErrorState extends BoardErrorState {
  BoardSelectedTasksUnCompletedMarkingErrorState({required super.errMessage});
}

class BoardSelectedTasksFavouriteMarkingState extends BoardLoadingState {
  BoardSelectedTasksFavouriteMarkingState()
      : super(
          loadingMessage: markSelectedTasksFavouriteLoadingText,
        );
}

class BoardSelectedTasksFavouriteMarkedState extends BoardLoadedState {}

class BoardSelectedTasksFavouriteMarkingErrorState extends BoardErrorState {
  BoardSelectedTasksFavouriteMarkingErrorState({required super.errMessage});
}

class BoardSelectedTasksUnFavouriteMarkingState extends BoardLoadingState {
  BoardSelectedTasksUnFavouriteMarkingState()
      : super(
          loadingMessage: markSelectedTasksUnFavouriteLoadingText,
        );
}

class BoardSelectedTasksUnFavouriteMarkedState extends BoardLoadedState {}

class BoardSelectedTasksUnFavouriteMarkingErrorState extends BoardErrorState {
  BoardSelectedTasksUnFavouriteMarkingErrorState({required super.errMessage});
}

class BoardSingleNotificationDeletingState extends BoardLoadingState {
  BoardSingleNotificationDeletingState({super.loadingMessage});
}

class BoardSingleNotificationDeletedState extends BoardLoadedState {}

class BoardSingleNotificationDeletingErrorState extends BoardErrorState {
  BoardSingleNotificationDeletingErrorState({required super.errMessage});
}

class BoardSingleNotificationReadMarkingState extends BoardLoadingState {
  BoardSingleNotificationReadMarkingState({super.loadingMessage});
}

class BoardSingleNotificationReadMarkedState extends BoardLoadedState {}

class BoardSingleNotificationReadMarkingErrorState extends BoardErrorState {
  BoardSingleNotificationReadMarkingErrorState({required super.errMessage});
}

class BoardSingleNotificationUnReadMarkingState extends BoardLoadingState {
  BoardSingleNotificationUnReadMarkingState({super.loadingMessage});
}

class BoardSingleNotificationUnReadMarkedState extends BoardLoadedState {}

class BoardSingleNotificationUnReadMarkingErrorState extends BoardErrorState {
  BoardSingleNotificationUnReadMarkingErrorState({required super.errMessage});
}

class BoardAllNotificationsReadMarkingState extends BoardLoadingState {
  BoardAllNotificationsReadMarkingState({super.loadingMessage});
}

class BoardAllNotificationsReadMarkedState extends BoardLoadedState {}

class BoardAllNotificationsReadMarkingErrorState extends BoardErrorState {
  BoardAllNotificationsReadMarkingErrorState({required super.errMessage});
}

class BoardSingleTaskDeletingState extends BoardLoadingState {
  BoardSingleTaskDeletingState({super.loadingMessage});
}

class BoardSingleTaskDeletedState extends BoardLoadedState {}

class BoardSingleTaskDeletingErrorState extends BoardErrorState {
  BoardSingleTaskDeletingErrorState({required super.errMessage});
}

class BoardSingleTaskCompletedMarkingState extends BoardLoadingState {
  BoardSingleTaskCompletedMarkingState({super.loadingMessage});
}

class BoardSingleTaskCompletedMarkedState extends BoardLoadedState {}

class BoardSingleTaskCompletedMarkingErrorState extends BoardErrorState {
  BoardSingleTaskCompletedMarkingErrorState({required super.errMessage});
}

class BoardSingleTaskUnCompletedMarkingState extends BoardLoadingState {
  BoardSingleTaskUnCompletedMarkingState({super.loadingMessage});
}

class BoardSingleTaskUnCompletedMarkedState extends BoardLoadedState {}

class BoardSingleTaskUnCompletedMarkingErrorState extends BoardErrorState {
  BoardSingleTaskUnCompletedMarkingErrorState({required super.errMessage});
}

class BoardSingleTaskFavouriteMarkingState extends BoardLoadingState {
  BoardSingleTaskFavouriteMarkingState({super.loadingMessage});
}

class BoardSingleTaskFavouriteMarkedState extends BoardLoadedState {}

class BoardSingleTaskFavouriteMarkingErrorState extends BoardErrorState {
  BoardSingleTaskFavouriteMarkingErrorState({required super.errMessage});
}

class BoardSingleTaskUnFavouriteMarkingState extends BoardLoadingState {
  BoardSingleTaskUnFavouriteMarkingState({super.loadingMessage});
}

class BoardSingleTaskUnFavouriteMarkedState extends BoardLoadedState {}

class BoardSingleTaskUnFavouriteMarkingErrorState extends BoardErrorState {
  BoardSingleTaskUnFavouriteMarkingErrorState({required super.errMessage});
}

class BoardAfterCreateTasksUpdatingState extends BoardLoadingState {
  BoardAfterCreateTasksUpdatingState({super.loadingMessage});
}

class BoardAfterCreateTasksUpdatedState extends BoardLoadedState {}

class BoardAfterCreateTasksUpdatingErrorState extends BoardErrorState {
  BoardAfterCreateTasksUpdatingErrorState({required super.errMessage});
}

class BoardSelectedTasksUIUpdatingState extends BoardLoadingState {}

class BoardSelectedTasksUIUpdatedState extends BoardLoadedState {}

class BoardSelectedTasksUIUpdatingErrorState extends BoardErrorState {
  BoardSelectedTasksUIUpdatingErrorState({required super.errMessage});
}
