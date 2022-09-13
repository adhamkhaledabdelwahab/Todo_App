import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/src/core/routes/routes.dart';
import 'package:todo_app/src/presentation/bloc/app_bloc/app_bloc.dart';

Future<void> onAppResumeFromTaskNotificationSelect(
  String route,
  BuildContext context,
) async {
  final task = AppBloc.get(context).appLaunchTask;
  if (task != null) {
    if (route == taskScreenRouteFromTask) {
      Get.offAndToNamed(
        route,
        arguments: task,
      );
    } else {
      Get.toNamed(
        route,
        arguments: task,
      );
    }
  }
}
