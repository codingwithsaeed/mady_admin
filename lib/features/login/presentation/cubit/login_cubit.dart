import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/domain/entities/admin.dart';
import 'package:mady_admin/features/login/domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUsecase;
  LoginCubit(this.loginUsecase) : super(const InitialState());

  Future<void> doAuth(String? username, String? password) async {
    emit(const LodingState());

    if (username == null || username == '') {
      emit(const ErrorState('نام کاربری را وارد کنید'));
      return;
    }

    if (password == null || password == '') {
      emit(const ErrorState('گذرواژه را وارد کنید'));
      return;
    }

    final res = await loginUsecase(
      Params({'username': username, 'password': password, 'action': 'signin'}),
    );
    res.fold((failure) {
      if (failure is ServerFailure) emit(ErrorState(failure.message));
    }, (admin) {
      emit(LoadedState(admin));
    });
  }
}
