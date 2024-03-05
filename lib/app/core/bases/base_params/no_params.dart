import 'package:json_annotation/json_annotation.dart';

part 'no_params.g.dart';

@JsonSerializable()
class NoParams {
  const NoParams();

  Map<String, dynamic> toJson() => _$NoParamsToJson(this);}
