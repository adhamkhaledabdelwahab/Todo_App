import 'package:todo_app/src/core/errors/exceptions.dart';
import 'package:todo_app/src/core/utils/workmanager_callback.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerProvider {
  static final _instance = WorkManagerProvider._internal();
  static WorkManagerProvider get = _instance;
  bool isInitialized = false;
  late Workmanager _workManager;

  WorkManagerProvider._internal();

  Future<Workmanager> workManger() async {
    if (!isInitialized) await init();
    return _workManager;
  }

  Future init() async {
    try {
      Workmanager workmanager = Workmanager();
      await workmanager.initialize(workMangerNotificationTaskExecute);
      _workManager = workmanager;
      isInitialized = true;
    } catch (e) {
      throw NotificationWorkManagerInitializationException();
    }
  }
}
