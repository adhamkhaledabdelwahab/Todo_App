import 'package:flutter/material.dart';
import 'package:todo_app/src/presentation/bloc/scheduled_tasks_bloc/scheduled_tasks_bloc.dart';
import 'package:todo_app/src/presentation/widgets/scheduled_tasks_widgets/schedule_date_list_item.dart';

class HorizontalDatePickerListView extends StatelessWidget {
  const HorizontalDatePickerListView({
    Key? key,
    required this.datePickerDates,
    required this.selectedDate,
    required this.getDayAbbr,
    required this.getMonthAbbr,
  }) : super(key: key);

  final List<DateTime> datePickerDates;
  final DateTime? selectedDate;
  final String Function(int weekDay) getDayAbbr;
  final String Function(int month) getMonthAbbr;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: datePickerDates.length,
      itemBuilder: (_, index) {
        return DateListItem(
          isSelected: selectedDate != null
              ? datePickerDates.indexOf(selectedDate!) == index
              : false,
          weekDay: getDayAbbr(datePickerDates[index].weekday),
          day: datePickerDates[index].day,
          month: getMonthAbbr(datePickerDates[index].month),
          onTap: () => ScheduledTasksBloc.get(context)
              .add(ScheduledTasksUpdateSelectedDate(
            selectedDate: datePickerDates[index],
          )),
        );
      },
    );
  }
}
