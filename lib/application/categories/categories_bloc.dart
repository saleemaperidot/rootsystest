import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:roottest/domain/categories/models/category_model/category_model.dart';
import 'package:roottest/domain/categories/repo/catogory_repo.dart';
import 'package:roottest/domain/core/failure/mainfailure.dart';

part 'categories_event.dart';
part 'categories_state.dart';
part 'categories_bloc.freezed.dart';

@injectable
class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoryService _categoryService;
  CategoriesBloc(this._categoryService) : super(CategoriesState.initial()) {
    on<CategoryInitial>((event, emit) async {
      emit(CategoriesState(
          category: [], status: false, isLoading: true, hasError: false));
      final result = await _categoryService.category();
      print(result);
      final _state = result.fold((MainFailure f) {
        return CategoriesState(
            category: [], status: false, isLoading: false, hasError: true);
      }, (r) {
        return CategoriesState(
            category: r, status: true, isLoading: false, hasError: false);
      });
      emit(_state);
    });
  }
}
