import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/request/domain/entities/request.dart';
import 'package:mady_admin/features/request/domain/usecases/request_usecase.dart';

part 'request_state.dart';

@injectable
class RequestCubit extends Cubit<RequestState> {
  final RequestUsecase _usecase;
  RequestCubit(this._usecase) : super(const RequestInitial());

  Future<void> getRequests() async {
    emit(const RequestLoading());

    final res = await _usecase(NoParams());
    res.fold((failure) {
      if (failure is ServerFailure) emit(RequestError(failure.message));
    }, (requests) {
      emit(RequestLoaded(requests));
    });
  }
}
