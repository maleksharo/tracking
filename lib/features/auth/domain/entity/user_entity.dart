import 'package:tracking/app/core/entities/entity.dart';

class UserEntity extends Entity {
  final String token;

  UserEntity({required this.token});

  @override
  List<Object?> get props => [token];
}
