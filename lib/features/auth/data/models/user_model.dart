import 'package:tracking/app/extensions.dart';
import 'package:tracking/features/auth/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel {
  final String? token;

  UserModel({this.token});

  UserEntity toEntity() => UserEntity(token: token.orEmpty());

  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(token: userEntity.token);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
