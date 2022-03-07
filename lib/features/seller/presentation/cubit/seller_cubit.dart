import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/seller/domain/entities/seller.dart';
import 'package:mady_admin/features/seller/domain/usecases/seller_usecase.dart';

part 'seller_state.dart';

@injectable
class SellerCubit extends Cubit<SellerState> {
  final SellerUsecase _usecase;

  SellerCubit(this._usecase) : super(const SellerInitial());

  Future<void> getSellers() async {
    emit(const SellerLoading());

    final result = await _usecase.getSellers(const Params({'action': 'get_sellers_list'}));
    result.fold((failure) {
      if (failure is ServerFailure) emit(SellerError(failure.message));
    }, (list) => emit(SellerLoaded(list)));
  }
}
