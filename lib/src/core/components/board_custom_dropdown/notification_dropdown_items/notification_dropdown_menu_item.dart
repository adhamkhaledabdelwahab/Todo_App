import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/core/components/board_custom_dropdown/custom_dropdown.dart';
import 'package:todo_app/src/core/components/board_custom_dropdown/custom_dropdown_general_items/custom_dropdown_menuitem_container.dart';
import 'package:todo_app/src/core/components/board_custom_dropdown/custom_dropdown_general_items/custom_dropdown_text_menuitem.dart';
import 'package:todo_app/src/data/models/notification_model.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/presentation/bloc/board_bloc/board_bloc.dart';

class NotificationDropdownMenuItemWidget extends StatelessWidget {
  const NotificationDropdownMenuItemWidget({
    Key? key,
    required this.taskModel,
    required this.markNotificationAsRead,
    required this.notificationModel,
  }) : super(key: key);

  final TaskModel taskModel;
  final NotificationModel notificationModel;
  final Function(NotificationModel notification) markNotificationAsRead;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                taskModel.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              if (taskModel.description.isNotEmpty)
                const SizedBox(
                  height: 5,
                ),
              if (taskModel.description.isNotEmpty)
                Text(
                  taskModel.description,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    DateFormat('dd MMMM, yyyy').format(
                      DateFormat.yMd().parse(taskModel.date),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    taskModel.startTime,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              notificationModel.isRead == 0
                  ? Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => markNotificationAsRead(
                            notificationModel,
                          ),
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              CustomDropDown(
                onChange: (int value) {
                  switch (value) {
                    case 0:
                      notificationModel.isRead == 0
                          ? BoardBloc.get(context).add(
                              BoardMarkSingleNotificationAsRead(
                                notification: notificationModel,
                              ),
                            )
                          : BoardBloc.get(context).add(
                              BoardMarkSingleNotificationAsUnRead(
                                notification: notificationModel,
                              ),
                            );
                      break;
                    case 1:
                      BoardBloc.get(context).add(
                        BoardDeleteSingleNotification(
                          notification: notificationModel,
                        ),
                      );
                      break;
                  }
                },
                dropMenuItems: {
                  0: notificationModel.isRead == 0
                      ? 'Mark As Read'
                      : 'Mark As UnRead',
                  1: 'Remove Notification'
                }
                    .map((key, value) {
                      return MapEntry(
                        key,
                        CustomDropDownMenuItemContainer(
                          child: CustomDropdownTextMenuItem(
                            value: value,
                          ),
                        ),
                      );
                    })
                    .values
                    .toList(),
                buttonIcon: Icons.more_vert_outlined,
                iconColor: Colors.white,
                dropMenuBackgroundColor: Colors.teal,
                isNotification: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
