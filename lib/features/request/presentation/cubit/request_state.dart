part of 'request_cubit.dart';

abstract class RequestState extends Equatable {
  const RequestState();

  @override
  List<Object> get props => [];
}

class RequestInitial extends RequestState {}
