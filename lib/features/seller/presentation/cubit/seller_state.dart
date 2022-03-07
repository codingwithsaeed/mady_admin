part of 'seller_cubit.dart';

abstract class SellerState extends Equatable {
  const SellerState();

  @override
  List<Object> get props => [];
}

class SellerInitial extends SellerState {
  const SellerInitial();
}

class SellerLoading extends SellerState {
  const SellerLoading();
}

class SellerLoaded extends SellerState {
  final List<Seller> list;

  const SellerLoaded(this.list);

  @override
  List<Object> get props => [list];
}

class SellerError extends SellerState {
  final String message;

  const SellerError(this.message);

  @override
  List<Object> get props => [message];
}
