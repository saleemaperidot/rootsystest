import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';
import 'package:roottest/domain/core/apis/apis.dart';
import 'package:roottest/domain/core/failure/mainfailure.dart';
import 'package:roottest/domain/login/Models/login/login.dart';
import 'package:roottest/domain/login/Models/login_request/login_request.dart';
import 'package:roottest/domain/login/repo/login_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: LoginServices)
class LoginImplementation extends LoginServices {
  @override
  Future<Either<MainFailure, Login>> login(
      {required LoginRequest loginRequest}) async {
    print("implementation");
    try {
      // final response = await http.post(uri,
      //     body: jsonEncode(
      //         {'email': "waiter@gmail.com", 'password': "waiter123"}),
      //     headers: headers);
      // final data = LoginRequest(
      //     email: loginRequest.email, password: loginRequest.password);
      final response = await Dio().post(Apis.login,
          options: Options(headers: {
            'Content-Type': 'application/json',
            // 'Authorization':
            //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE0MzgwNjI1LCJpYXQiOjE3MDY2MDQ2MjUsImp0aSI6ImQ3MDUxNWQzOWMyYjQ2NjY5MWUxOTQwMDljOTYzZmE3IiwidXNlcl9pZCI6NH0.aJR4-1XaVHyaKdqIu8-ZrcJAPBu61t0KA-1OlGOggNQ'
          }),
          data: loginRequest.toJson());
      print(response.data.toString());
      if (response.statusCode == 200) {
        final result = Login.fromJson(response.data);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("token", response.data['token']['access']);
        return Right(result);
      } else {
        print("error");
        print(response.statusCode);
        return Left(MainFailure.ServerFailure());
      }
    } catch (e) {
      print(e);
      return const Left(MainFailure.ClientFailure());
    }
  }
}
