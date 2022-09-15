// ignore_for_file: depend_on_referenced_packages

import 'package:get_it/get_it.dart';
import 'package:notifications_listener_service/notifications_listener_service.dart';
import 'package:todo_app/src/core/database/database.dart';
import 'package:todo_app/src/core/notification/notification.dart';
import 'package:todo_app/src/core/utils/notification_listener_service_callback.dart';
import 'package:todo_app/src/data/data_sources/data_sources.dart';
import 'package:todo_app/src/data/repository/task_repository_impl.dart';
import 'package:todo_app/src/domain/repository/task_repository.dart';
import 'package:todo_app/src/domain/use_cases/use_cases.dart';
import 'package:todo_app/src/presentation/bloc/bloc.dart';


final serviceLocator = GetIt.instance;

Future<void> init() async {
  /// Bloc
  serviceLocator.registerFactory(
    () => AppBloc(
      getInitAppServices: serviceLocator(),
      getQuerySingleNotification: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => BoardBloc(
      getFetchNotifications: serviceLocator(),
      getFetchTasks: serviceLocator(),
      getQueryAllNotifications: serviceLocator(),
      getQueryAllTasks: serviceLocator(),
      getQuerySelectedTasks: serviceLocator(),
      getQuerySingleNotification: serviceLocator(),
      getQuerySingleTask: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => CreateTaskBloc(
      getQuerySingleTask: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => ScheduledTasksBloc(
      getFetchTasks: serviceLocator(),
    ),
  );

  /// Use cases
  serviceLocator.registerLazySingleton(
    () => GetInitAppServices(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetFetchNotifications(
      taskRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetFetchTasks(
      taskRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetQueryAllNotifications(
      taskRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetQueryAllTasks(
      taskRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetQuerySelectedTasks(
      taskRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetQuerySingleNotification(
      taskRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetQuerySingleTask(
      taskRepository: serviceLocator(),
    ),
  );

  /// Repository
  serviceLocator.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      taskDatabaseDataSource: serviceLocator(),
      taskNotificationDataSource: serviceLocator(),
    ),
  );

  /// Data sources
  serviceLocator.registerLazySingleton<TaskDatabaseDataSource>(
    () => TaskDatabaseDataSourceImpl(
      databaseService: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<TaskNotificationDataSource>(
    () => TaskNotificationDataSourceImpl(
      notificationService: serviceLocator(),
    ),
  );

  /// Core
  serviceLocator.registerLazySingleton<NotificationService>(
    () => NotificationServiceImpl(
      workManagerProvider: serviceLocator(),
      notificationProvider: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DatabaseService>(
    () => DatabaseServiceImpl(
      databaseProvider: serviceLocator(),
    ),
  );

  /// External
  serviceLocator.registerLazySingleton<WorkManagerProvider>(
    () => WorkManagerProvider.get,
  );
  serviceLocator.registerLazySingleton<NotificationProvider>(
    () => NotificationProvider.get,
  );
  serviceLocator.registerLazySingleton<DatabaseProvider>(
    () => DatabaseProvider.get,
  );

  await NotificationServicePlugin.instance.initialize(onNotificationStateChanges);
}
