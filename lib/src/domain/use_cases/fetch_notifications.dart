import 'package:dartz/dartz.dart';
import 'package:todo_app/src/core/database/database_fetch_params.dart';
import 'package:todo_app/src/core/errors/failures.dart';
import 'package:todo_app/src/core/use_cases/use_cases.dart';
import 'package:todo_app/src/data/models/notification_model.dart';
import 'package:todo_app/src/domain/repository/task_repository.dart';

class GetFetchNotifications
    extends UseCase<Failures, List<NotificationModel>, DatabaseFetchParams> {
  final TaskRepository taskRepository;

  GetFetchNotifications({required this.taskRepository});

  @override
  Future<Either<Failures, List<NotificationModel>>> call(
    DatabaseFetchParams params,
  ) async {
    return await taskRepository.fetchAllNotifications(
      databaseFetchParams: params,
    );
  }
}
