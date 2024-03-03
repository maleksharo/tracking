import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response_meta_data.g.dart';

@JsonSerializable()
class ApiResponseMetaData extends Equatable {
  @JsonKey(defaultValue: -1)
  final int status;
  @JsonKey(defaultValue: "")
  final String message;
  @JsonKey(defaultValue: "")
  final String key;

  const ApiResponseMetaData({
    required this.status,
    required this.key,
    required this.message,
  });

  factory ApiResponseMetaData.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseMetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseMetaDataToJson(this);

  @override
  List<Object?> get props => [status, key, message];
}
