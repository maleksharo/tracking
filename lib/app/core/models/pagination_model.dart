import 'package:tracking/app/core/entities/pagination_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaginationModel {
  final int? total;
  final int? count;
  final int? perPage;
  final int? currentPage;
  final int? totalPages;

  PaginationModel({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  PaginationEntity toEntity() => PaginationEntity(
        total: total,
        count: count,
        perPage: perPage,
        currentPage: currentPage,
        totalPages: totalPages,
      );

  factory PaginationModel.fromEntity(PaginationEntity paginationEntity) {
    return PaginationModel(
      total: paginationEntity.total,
      totalPages: paginationEntity.totalPages,
      currentPage: paginationEntity.currentPage,
      perPage: paginationEntity.perPage,
      count: paginationEntity.count,
    );
  }

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
}
