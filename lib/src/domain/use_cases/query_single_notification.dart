import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/core/errors/failures.dart';
import 'package:todo_app/src/core/use_cases/use_cases.dart';
import 'package:todo_app/src/data/models/notification_model.dart';
import 'package:todo_app/src/domain/repository/task_repository.dart';

enum QuerySingleNotification {
  markSingleNotificationAsRead,
  markSingleNotificationAsUnRead,
  deleteSingleNotification,
}

class GetQuerySingleNotification extends UseCase<
    Either<Failures, NotificationModel>,
    Either<Failures, void>,
    QuerySingleNotificationParams> {
  final TaskRepository taskRepository;

  GetQuerySingleNotification({required this.taskRepository});

  @override
  Future<Either<Either<Failures, NotificationModel>, Either<Failures, void>>>
      call(QuerySingleNotificationParams params) async {
    switch (params.querySingleNotification) {
      case QuerySingleNotification.deleteSingleNotification:
        return Right(
          await taskRepository.deleteSingleNotification(
            notification: params.notification,
          ),
        );
      case QuerySingleNotification.markSingleNotificationAsRead:
        return Left(
          await taskRepository.markSingleNotificationAsRead(
            notification: params.notification,
          ),
        );
      case QuerySingleNotification.markSingleNotificationAsUnRead:
        return Left(
          await taskRepository.markSingleNotificationAsUnRead(
            notification: params.notification,
          ),
        );
    }
  }
}

class QuerySingleNotificationParams extends Equatable {
  final QuerySingleNotification querySingleNotification;
  final NotificationModel notification;

  const QuerySingleNotificationParams({
    required this.querySingleNotification,
    required this.notification,
  });

  @override
  List<Object?> get props => [
        querySingleNotification,
        notification,
      ];
}
