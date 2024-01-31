import 'package:json_annotation/json_annotation.dart';

import 'token.dart';
import 'user_data.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  Token? token;
  @JsonKey(name: 'user_data')
  UserData? userData;
  String? msg;

  Login({this.token, this.userData, this.msg});

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
