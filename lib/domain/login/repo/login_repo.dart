import 'package:dartz/dartz.dart';
import 'package:roottest/domain/core/failure/mainfailure.dart';
import 'package:roottest/domain/login/Models/login/login.dart';
import 'package:roottest/domain/login/Models/login_request/login_request.dart';

abstract class LoginServices {
  Future<Either<MainFailure, Login>> login(
      {required LoginRequest loginRequest});
}
