import 'dart:ui';

import 'package:todo_app/src/core/constants/board_screen_consts.dart';

void restartNotificationUpdateIsolate() {
  IsolateNameServer.removePortNameMapping(boardNotificationUpdateIsolateName);
  IsolateNameServer.registerPortWithName(
    boardNotificationUpdateReceivePort.sendPort,
    boardNotificationUpdateIsolateName,
  );
  IsolateNameServer.removePortNameMapping(appNotificationSelectIsolateName);
  IsolateNameServer.registerPortWithName(
    appNotificationSelectReceivePort.sendPort,
    appNotificationSelectIsolateName,
  );
}
