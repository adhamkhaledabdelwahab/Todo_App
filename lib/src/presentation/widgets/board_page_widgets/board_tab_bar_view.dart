import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/core/components/tasks_view_error_widget.dart';
import 'package:todo_app/src/presentation/bloc/bloc.dart';
import 'package:todo_app/src/presentation/widgets/board_page_widgets/board_tabbar_view_widget.dart';

class BoardTabBarView extends StatelessWidget {
  const BoardTabBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoardBloc, BoardState>(
      builder: (context, state) {
        return Expanded(
          child: TabBarView(
            children: [
              state is BoardAllTasksFetchingErrorState
                  ? TasksViewErrorWidget(
                      errMessage: state.errMessage,
                    )
                  : BoardTabBarViewWidget(
                      tasks: BoardBloc.get(context).allTasks,
                      isLoading: state is BoardAllTasksFetchingState,
                      selectedTasks: BoardBloc.get(context).selectedTasksAll,
                      updateSelectedTasks: UpdateSelectedTasks.allTasks,
                    ),
              state is BoardCompletedTasksFetchingErrorState
                  ? TasksViewErrorWidget(
                      errMessage: state.errMessage,
                    )
                  : BoardTabBarViewWidget(
                      tasks: BoardBloc.get(context).completedTasks,
                      isLoading: state is BoardCompletedTasksFetchingState,
                      selectedTasks:
                          BoardBloc.get(context).selectedTasksCompleted,
                      updateSelectedTasks: UpdateSelectedTasks.completedTasks,
                    ),
              state is BoardUnCompletedTasksFetchingErrorState
                  ? TasksViewErrorWidget(
                      errMessage: state.errMessage,
                    )
                  : BoardTabBarViewWidget(
                      tasks: BoardBloc.get(context).unCompletedTasks,
                      isLoading: state is BoardUnCompletedTasksFetchingState,
                      selectedTasks:
                          BoardBloc.get(context).selectedTasksUnCompleted,
                      updateSelectedTasks: UpdateSelectedTasks.unCompletedTasks,
                    ),
              state is BoardFavouriteTasksFetchingErrorState
                  ? TasksViewErrorWidget(
                      errMessage: state.errMessage,
                    )
                  : BoardTabBarViewWidget(
                      tasks: BoardBloc.get(context).favouriteTasks,
                      isLoading: state is BoardFavouriteTasksFetchingState,
                      selectedTasks:
                          BoardBloc.get(context).selectedTasksFavourite,
                      updateSelectedTasks: UpdateSelectedTasks.favouriteTasks,
                    ),
            ],
          ),
        );
      },
    );
  }
}
