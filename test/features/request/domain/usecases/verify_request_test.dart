import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/request/domain/usecases/verify_request_usecase.dart';
import 'package:mockito/mockito.dart';
import 'request_usecase_test.mocks.dart';

void main() {
  late VerifyRequestUsecase sut;
  late MockRequestRepository repository;

  setUp(() {
    repository = MockRequestRepository();
    sut = VerifyRequestUsecase(repository);
  });

  group('Testing Verfiy Request', () {
    test(
      "Should return [Right(true)] if call to repository is succeeded",
      () async {
        //arrange
        when(repository.verifyRequest(any))
            .thenAnswer((_) async => const Right(true));
        //act
        final result = await sut(
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
        final result = await sut(
          const Params({'action': 'accept_seller', 'srid': '7'}),
        );
        //assert
        expect(result, Left(ServerFailure(message: NO_INTERNET_CONNECTION)));
      },
    );
  });
}
