import 'package:dartz/dartz.dart';
import 'package:roottest/domain/categories/models/category_model/category_model.dart';
import 'package:roottest/domain/core/failure/mainfailure.dart';
import 'package:roottest/domain/login/Models/login/login.dart';

abstract class CategoryService {
  Future<Either<MainFailure, List<CategoryModel>>> category();
}
