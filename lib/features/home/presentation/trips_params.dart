import 'package:json_annotation/json_annotation.dart';
part 'trips_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TripParams {
  final String from;
  final String to;

  TripParams({required this.from, required this.to});

  Map<String, dynamic> toJson() => _$TripParamsToJson(this);
}
