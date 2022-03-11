import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/offer/domain/entities/offer.dart';
import 'package:mady_admin/features/offer/domain/usecases/offer_usecase.dart';
part 'offer_state.dart';

@injectable
class OfferCubit extends Cubit<OfferState> {
  final OfferUsecase _usecase;

  OfferCubit(this._usecase) : super(const OfferInitial());

  Future<void> getAllOffers() async {
    emit(const OfferLoading());

    final result =
        await _usecase.getAllOffers(const Params({'action': 'get_all_offers'}));
    result.fold((failure) {
      if (failure is ServerFailure) emit(OfferError(failure.message));
    }, (list) {
      emit(OfferLoaded(list));
    });
  }
}
