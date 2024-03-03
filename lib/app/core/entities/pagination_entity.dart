import 'package:tracking/app/core/entities/entity.dart';

class PaginationEntity extends Entity {
  final int? total;
  final int? count;
  final int? perPage;
  final int? currentPage;
  final int? totalPages;

  PaginationEntity({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  @override
  List<Object?> get props => [
        total,
        count,
        perPage,
        currentPage,
        totalPages,
      ];
}
