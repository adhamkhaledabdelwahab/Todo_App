import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/core/components/empty_list_view.dart';
import 'package:todo_app/src/core/components/tasks_view_error_widget.dart';
import 'package:todo_app/src/presentation/bloc/scheduled_tasks_bloc/scheduled_tasks_bloc.dart';
import 'package:todo_app/src/presentation/widgets/scheduled_tasks_widgets/widgets.dart';

class SelectedDateTasks extends StatelessWidget {
  const SelectedDateTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduledTasksBloc, ScheduledTasksState>(
      builder: (context, state) {
        Widget returnedWidget = Container();
        if (state is ScheduledTasksInitializingErrorState ||
            state is ScheduledTasksSelectedDateUpdatingErrorState) {
          returnedWidget = TasksViewErrorWidget(
            errMessage: (state is ScheduledTasksInitializingErrorState)
                ? (state).errMessage
                : (state as ScheduledTasksSelectedDateUpdatingErrorState)
                    .errMessage,
          );
        } else if ((state is ScheduledTasksInitializedState ||
                state is ScheduledTasksSelectedDateUpdatedState) &&
            ScheduledTasksBloc.get(context).selectedDateTasks.isEmpty) {
          returnedWidget = const EmptyListView();
        } else {
          returnedWidget = TaskListView(
            tasks: ScheduledTasksBloc.get(context).selectedDateTasks,
          );
        }
        return Expanded(
          child: returnedWidget,
        );
      },
    );
  }
}
