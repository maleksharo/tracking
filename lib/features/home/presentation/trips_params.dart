import 'package:json_annotation/json_annotation.dart';

part 'trips_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TripParams {
  final String from;
  final String to;
  final int tracCarDeviceId;

  TripParams({
    required this.from,
    required this.to,
    required this.tracCarDeviceId,
  });

  Map<String, dynamic> toJson() => _$TripParamsToJson(this);
}
