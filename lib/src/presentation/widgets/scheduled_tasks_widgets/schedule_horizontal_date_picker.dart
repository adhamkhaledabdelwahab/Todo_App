import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/core/components/tasks_view_error_widget.dart';
import 'package:todo_app/src/presentation/bloc/scheduled_tasks_bloc/scheduled_tasks_bloc.dart';
import 'package:todo_app/src/presentation/widgets/scheduled_tasks_widgets/schedule_horizontal_date_picker_list_view.dart';

class HorizontalDatePicker extends StatelessWidget {
  const HorizontalDatePicker({Key? key}) : super(key: key);

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
        } else {
          final scheduleCubit = ScheduledTasksBloc.get(context);
          returnedWidget = HorizontalDatePickerListView(
            selectedDate: scheduleCubit.selectedDate,
            datePickerDates: scheduleCubit.datePickerDates,
            getDayAbbr: scheduleCubit.getDayAbbr,
            getMonthAbbr: scheduleCubit.getMonthAbbr,
          );
        }
        return Container(
          height: 100,
          margin: const EdgeInsets.only(top: 10, left: 6, bottom: 5),
          child: returnedWidget,
        );
      },
    );
  }
}
