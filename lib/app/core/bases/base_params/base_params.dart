import 'package:json_annotation/json_annotation.dart';

part 'base_params.g.dart';

@JsonSerializable(genericArgumentFactories: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Params<T>  {
  @JsonKey(defaultValue: null)
  final T params;

  const Params({required this.params});


  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ParamsToJson(this, toJsonT);

}
