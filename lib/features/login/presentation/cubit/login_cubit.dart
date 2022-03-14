import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/di/injection.dart';
import 'package:mady_admin/features/login/domain/entities/admin.dart';
import 'package:mady_admin/features/login/domain/usecases/login_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUsecase;
  LoginCubit(this.loginUsecase) : super(const LoginInitial());

  Future<void> doAuth(String username, String password) async {
    emit(const LoginLoading());

    if (username.isEmpty) {
      emit(const LoginError('نام کاربری را وارد کنید'));
      return;
    }

    if (password.isEmpty) {
      emit(const LoginError('گذرواژه را وارد کنید'));
      return;
    }

    final res = await loginUsecase(
      Params({'username': username, 'password': password, 'action': 'signin'}),
    );
    res.fold(
      (failure) {
        if (failure is ServerFailure) emit(LoginError(failure.message));
      },
      (admin) {
        emit(LoginLoaded(admin));
        getIt<SharedPreferences>().setBool('LOGIN', true);
      },
    );
  }
}
