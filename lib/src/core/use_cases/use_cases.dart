import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type1, Type2, Params> {
  Future<Either<Type1, Type2>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
