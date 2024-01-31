// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../../application/categories/categories_bloc.dart' as _i7;
import '../../../application/login/login_bloc.dart' as _i8;
import '../../../infrastructure/category_implementation.dart' as _i4;
import '../../../infrastructure/login_implementation.dart' as _i6;
import '../../categories/repo/catogory_repo.dart' as _i3;
import '../../login/repo/login_repo.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.CategoryService>(() => _i4.CategoryImplementation());
  gh.lazySingleton<_i5.LoginServices>(() => _i6.LoginImplementation());
  gh.factory<_i7.CategoriesBloc>(
      () => _i7.CategoriesBloc(get<_i3.CategoryService>()));
  gh.factory<_i8.LoginBloc>(() => _i8.LoginBloc(get<_i5.LoginServices>()));
  return get;
}
