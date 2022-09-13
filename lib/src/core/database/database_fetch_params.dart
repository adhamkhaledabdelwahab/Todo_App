import 'package:equatable/equatable.dart';

class DatabaseFetchParams extends Equatable {
  final int? limit;
  final int? offset;

  const DatabaseFetchParams({
    this.limit,
    this.offset,
  });

  @override
  List<Object?> get props => [
        limit,
        offset,
      ];
}
