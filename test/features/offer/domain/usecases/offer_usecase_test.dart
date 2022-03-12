import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/offer/data/models/all_offers.dart';
import 'package:mady_admin/features/offer/domain/entities/offer.dart';
import 'package:mady_admin/features/offer/domain/repositories/offer_repository.dart';
import 'package:mady_admin/features/offer/domain/usecases/offer_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'offer_usecase_test.mocks.dart';

@GenerateMocks([OfferRepository])
void main() {
  late OfferUsecase sut;
  late MockOfferRepository repository;

  setUp(() {
    repository = MockOfferRepository();
    sut = OfferUsecase(repository);
  });

  group('Testing get all offers', () {
    const tParams = Params({'action': 'get_all_offers'});

    final List<Offer> tOffers =
        AllOffers.fromJson(jsonDecode(fixture('all_offers.json'))).offers;
    test(
      "should return a List<Offer> when call to repo is succeed",
      () async {
        //arrange
        when(repository.getAllOffers(any))
            .thenAnswer((_) async => Right(tOffers));
        //act
        final result = await sut.getAllOffers(tParams);
        //assert
        expect(result, Right(tOffers));
        verify(repository.getAllOffers(tParams));
        verifyNoMoreInteractions(repository);
      },
    );

    test(
      "should return a ServerFailure when  repo return it",
      () async {
        //arrange
        when(repository.getAllOffers(any)).thenAnswer(
            (_) async => Left(ServerFailure(message: noInternetConnection)));
        //act
        final result = await sut.getAllOffers(tParams);
        //assert
        expect(result, Left(ServerFailure(message: noInternetConnection)));
        verify(repository.getAllOffers(tParams));
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
