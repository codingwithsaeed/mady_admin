// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/features/splash/domain/usecases/splash_usecase.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final SplashUsecase _usecase;
  SplashCubit(this._usecase) : super(const SplashInitial());

  Future<void> checkLogin() async {
    emit(const SplashLoading());

    final result = await _usecase.checkIsLoggedIn();

    result.fold((failure) {
      if (failure is ServerFailure) emit(SplashError(failure.message));
    }, (isLoggedIn) {
      if (isLoggedIn)
        emit(const SplashLoggedIn());
      else
        emit(const SplashNotLoggedIn());
    });
  }
}
