part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashLoggedIn extends SplashState {
  const SplashLoggedIn();
}

class SplashNotLoggedIn extends SplashState {
  const SplashNotLoggedIn();
}
