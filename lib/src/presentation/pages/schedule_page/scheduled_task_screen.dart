import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/core/components/app_bar_widget.dart';
import 'package:todo_app/src/core/routes/routes.dart';
import 'package:todo_app/src/core/utils/screen_onresume_task_notification.dart';
import 'package:todo_app/src/injection_container.dart';
import 'package:todo_app/src/presentation/bloc/bloc.dart';
import 'package:todo_app/src/presentation/widgets/scheduled_tasks_widgets/widgets.dart';

class ScheduledTasksScreen extends StatefulWidget {
  const ScheduledTasksScreen({Key? key}) : super(key: key);

  @override
  State<ScheduledTasksScreen> createState() => _ScheduledTasksScreenState();
}

class _ScheduledTasksScreenState extends State<ScheduledTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (AppBloc.get(context).appLaunchTask != null) {
          onAppResumeFromTaskNotificationSelect(
            taskScreenRoute,
            context,
          ).then(
            (value) => AppBloc.get(context).add(
              AppUpdateAppLaunchTaskEvent(null),
            ),
          );
        }
      },
      child: BlocProvider<ScheduledTasksBloc>(
        create: (context) => serviceLocator<ScheduledTasksBloc>()
          ..add(
            ScheduledTasksInitialize(),
          ),
        child: BlocListener<ScheduledTasksBloc, ScheduledTasksState>(
          listener: (context, state) {
            debugPrint('$state');
          },
          child: Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: MyAppBar(
                text: "Schedule",
                isBoardScreen: false,
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  const HorizontalDatePicker(),
                  Divider(
                    color: Colors.grey[400],
                    thickness: 2,
                  ),
                  const SelectedDateWidget(),
                  const SelectedDateTasks(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
