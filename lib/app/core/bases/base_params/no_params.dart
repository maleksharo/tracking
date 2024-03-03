import 'package:json_annotation/json_annotation.dart';

part 'no_params.g.dart';

@JsonSerializable(genericArgumentFactories: true, includeIfNull: true, fieldRename: FieldRename.snake)
class NoParams {
  const NoParams();

  Map<String, dynamic> toJson() => _$NoParamsToJson(this);}
