import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'seller_state.dart';

class SellerCubit extends Cubit<SellerState> {
  SellerCubit() : super(SellerInitial());
}
