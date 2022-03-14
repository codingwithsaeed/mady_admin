part of 'offer_cubit.dart';

abstract class OfferState extends Equatable {
  const OfferState();

  @override
  List<Object> get props => [];
}

class OfferInitial extends OfferState {
  const OfferInitial();
}

class OfferLoading extends OfferState {
  const OfferLoading();
}

class OfferLoaded extends OfferState {
  final List<Offer> list;
  const OfferLoaded(this.list);
  @override
  List<Object> get props => [list];
}

class OfferError extends OfferState {
  final String message;
  const OfferError(this.message);
  @override
  List<Object> get props => [message];
}

class OfferPictureLoaded extends OfferState {
  final String link;

  const OfferPictureLoaded(this.link);

  @override
  List<Object> get props => [link];
}

class AddOfferSuccess extends OfferState {}
