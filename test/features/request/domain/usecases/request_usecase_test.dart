import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/request/domain/entities/request.dart';
import 'package:mady_admin/features/request/domain/repositories/request_repository.dart';
import 'package:mady_admin/features/request/domain/usecases/request_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'request_usecase_test.mocks.dart';

@GenerateMocks([RequestRepository])
void main() {
  late RequestUsecase sut;
  late MockRequestRepository repository;

  setUp(() {
    repository = MockRequestRepository();
    sut = RequestUsecase(repository);
  });

  group('Usecase Test', () {
    List<Request> requests = [
      Request(
          srid: "1",
          storeName: "عطر آویشن",
          phone: "+989136581814",
          category: "ATARI",
          address: "اصفهان - میدان انقلاب",
          website: "www.avishan.co",
          logo: "http://192.168.1.2/mady/uploads/logo/avish.jpg",
          lat: "32",
          lng: "51",
          pocket: "1"),
      Request(
          srid: "2",
          storeName: "2 عطر آویشن",
          phone: "+989136581815",
          category: "ATARI",
          address: "اصفهان - میدان سهروردی",
          website: "www.avishan.co",
          logo: "http://192.168.1.2/mady/uploads/logo/avish.jpg",
          lat: "32",
          lng: "51",
          pocket: "1"),
    ];
    test(
      "should return a list of [Request] objects when call to respository is success",
      () async {
        //arrange
        when(repository.getRequests()).thenAnswer((_) async => Right(requests));
        //act
        final result = await sut.getRequests();
        //assert
        expect(result, Right(requests));
        verify(repository.getRequests());
        verifyNoMoreInteractions(repository);
      },
    );

    test(
      "should return Failure on repository problems",
      () async {
        //arrange
        when(repository.getRequests())
            .thenAnswer((_) async => Left(ServerFailure(message: 'Server')));
        //act
        final result = await sut.getRequests();
        //assert
        expect(result, Left(ServerFailure(message: 'Server')));
        verify(repository.getRequests());
        verifyNoMoreInteractions(repository);
      },
    );
  });

  group('Testing Verfiy Request', () {
    test(
      "Should return [Right(true)] if call to repository is succeeded",
      () async {
        //arrange
        when(repository.verifyRequest(any))
            .thenAnswer((_) async => const Right(true));
        //act
        final result = await sut.verifyRequest(
          const Params({'action': 'accept_seller', 'srid': '7'}),
        );
        //assert
        expect(result, const Right(true));
        verify(repository.verifyRequest(
          const Params({'action': 'accept_seller', 'srid': '7'}),
        ));
        verifyNoMoreInteractions(repository);
      },
    );

    test(
      "Should return [Left(ServerFailure)] if call to repository is unsucceeded",
      () async {
        //arrange
        when(repository.verifyRequest(any)).thenAnswer(
            (_) async => Left(ServerFailure(message: NO_INTERNET_CONNECTION)));
        //act
        final result = await sut.verifyRequest(
          const Params({'action': 'accept_seller', 'srid': '7'}),
        );
        //assert
        expect(result, Left(ServerFailure(message: NO_INTERNET_CONNECTION)));
      },
    );
  });
}
