part of 'categories_bloc.dart';

@freezed
class CategoriesState with _$CategoriesState {
  const factory CategoriesState({
    required List<CategoryModel> category,
    required bool status,
    required bool isLoading,
    required bool hasError,
  }) = _Initial;
  factory CategoriesState.initial() => const CategoriesState(
      category: [], status: false, isLoading: false, hasError: false);
}
