import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';
import 'package:roottest/domain/categories/models/category_model/category_model.dart';
import 'package:roottest/domain/categories/repo/catogory_repo.dart';
import 'package:roottest/domain/core/apis/apis.dart';
import 'package:roottest/domain/core/failure/mainfailure.dart';
import 'package:roottest/domain/login/Models/login/login.dart';
import 'package:roottest/domain/login/Models/login_request/login_request.dart';
import 'package:roottest/domain/login/repo/login_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: CategoryService)
class CategoryImplementation extends CategoryService {
  @override
  Future<Either<MainFailure, List<CategoryModel>>> category() async {
    print("category implementation");
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final token = pref.getString("token");
      print(token);
      final response = await Dio().get(
        Apis.categories,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE0MzgwNjI1LCJpYXQiOjE3MDY2MDQ2MjUsImp0aSI6ImQ3MDUxNWQzOWMyYjQ2NjY5MWUxOTQwMDljOTYzZmE3IiwidXNlcl9pZCI6NH0.aJR4-1XaVHyaKdqIu8-ZrcJAPBu61t0KA-1OlGOggNQ'
        }),
      );
      print(response.data.toString());
      if (response.statusCode == 200) {
        final result = (response.data as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();

        return Right(result);
      } else {
        print(response.statusCode);
        return Left(MainFailure.ServerFailure());
      }
    } catch (e) {
      print(e);
      return const Left(MainFailure.ClientFailure());
    }
  }
}
