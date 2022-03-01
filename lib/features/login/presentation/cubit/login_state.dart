part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class InitialState extends LoginState {
  const InitialState();
}

class LodingState extends LoginState {
  const LodingState();
}

class LoadedState extends LoginState {
  final Admin admin;

  const LoadedState(this.admin);
}

class ErrorState extends LoginState {
  final String message;

  const ErrorState(this.message);
}