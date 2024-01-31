part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required bool status,
    required bool isLoading,
    required bool hasError,
  }) = _Initial;
  factory LoginState.initial() =>
      const LoginState(status: false, isLoading: false, hasError: false);
}
