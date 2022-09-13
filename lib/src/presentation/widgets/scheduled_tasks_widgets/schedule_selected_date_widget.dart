import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/presentation/bloc/scheduled_tasks_bloc/scheduled_tasks_bloc.dart';

class SelectedDateWidget extends StatelessWidget {
  const SelectedDateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduledTasksBloc, ScheduledTasksState>(
      builder: (context, state) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ScheduledTasksBloc.get(context).selectedDate != null
                    ? ScheduledTasksBloc.get(context)
                        .fetchingSelectedDateWeekDay(
                            ScheduledTasksBloc.get(context)
                                .selectedDate!
                                .weekday)
                    : '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                ScheduledTasksBloc.get(context).selectedDate != null
                    ? DateFormat('dd MMMM, yyyy')
                        .format(ScheduledTasksBloc.get(context).selectedDate!)
                    : '',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey.shade600),
              ),
            ],
          ),
        );
      },
    );
  }
}
