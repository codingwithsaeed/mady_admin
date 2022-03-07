import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/presentation/cubit/login_cubit.dart';
import 'package:mady_admin/features/request/domain/entities/request.dart';
import 'package:mady_admin/features/request/domain/usecases/request_usecase.dart';

part 'request_state.dart';

@injectable
class RequestCubit extends Cubit<RequestState> {
  final RequestUsecase _usecase;
  RequestCubit(this._usecase) : super(const RequestInitial());

  Future<void> getRequests() async {
    emit(const RequestLoading());

    final res = await _usecase.getRequests();
    res.fold((failure) {
      if (failure is ServerFailure) emit(RequestError(failure.message));
    }, (requests) {
      emit(RequestLoaded(requests));
    });
  }

  Future<void> verifyRequest(String requestId, String action) async {
    emit(const RequestLoading());
    final res = await _usecase.verifyRequest(
      Params({'srid': requestId, 'action': action}),
    );
    res.fold((failure) {
      if (failure is ServerFailure) emit(RequestError(failure.message));
    }, (isDone) => emit(const VerifyRequestLoaded()));
  }
}
