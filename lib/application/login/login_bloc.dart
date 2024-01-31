import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:roottest/domain/core/failure/mainfailure.dart';
import 'package:roottest/domain/login/Models/login_request/login_request.dart';
import 'package:roottest/domain/login/repo/login_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginServices _loginServices;
  LoginBloc(this._loginServices) : super(LoginState.initial()) {
    on<LoginInitial>((event, emit) async {
      print("called");
      // TODO: implement event handler
      emit(state.copyWith(hasError: false, isLoading: true, status: false));
      final result =
          await _loginServices.login(loginRequest: event.loginrequest);
      final _state = result.fold((MainFailure f) {
        return LoginState(status: false, isLoading: false, hasError: true);
      }, (r) {
        return LoginState(status: true, isLoading: false, hasError: false);
      });
      emit(_state);
    });
  }
}
