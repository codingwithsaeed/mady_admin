part of 'request_cubit.dart';

abstract class RequestState extends Equatable {
  const RequestState();

  @override
  List<Object> get props => [];
}

class RequestInitial extends RequestState {
  const RequestInitial();
}

class RequestLoading extends RequestState {
  const RequestLoading();
}

class RequestLoaded extends RequestState {
  final List<Request> requests;

  const RequestLoaded(this.requests);
}

class RequestError extends RequestState {
  final String message;

  const RequestError(this.message);
}

class VerifyRequestLoaded extends RequestState {
  const VerifyRequestLoaded();
}
