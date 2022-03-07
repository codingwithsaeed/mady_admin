part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginLoaded extends LoginState {
  final Admin admin;

  const LoginLoaded(this.admin);
}

class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);
}