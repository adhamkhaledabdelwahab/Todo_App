import 'package:dartz/dartz.dart';
import 'package:todo_app/src/core/errors/failures.dart';
import 'package:todo_app/src/core/use_cases/use_cases.dart';
import 'package:todo_app/src/domain/repository/task_repository.dart';

class GetInitAppServices implements UseCase<Failures, void, NoParams> {
  final TaskRepository repository;

  const GetInitAppServices({
    required this.repository,
  });

  @override
  Future<Either<Failures, void>> call(NoParams params) async {
    return await repository.initAppServices();
  }
}
