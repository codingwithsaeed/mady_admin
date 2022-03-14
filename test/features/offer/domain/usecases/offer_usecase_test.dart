import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/models/base_model.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/offer/data/models/all_offers.dart';
import 'package:mady_admin/features/offer/domain/entities/add_offer.dart';
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

  group('Testing Add offer', () {
    final tAddOffer = AddOffer(
      sellerPhone: "09136581814",
      content: "بسته ده تایی گوشت بوقلمون",
      date: "1400-12-23",
      sTime: "14:00",
      eTime: "23:59",
      price: "30000",
      percent: "50",
      currentPrice: "15000",
      picture: "http://192.168.1.2/mady/uploads/offerpics/meat.jpeg",
      count: "20",
      isSpecial: "1",
      status: "0",
    );

    final tParams = Params(tAddOffer.toJson());

    final tJson = jsonDecode(fixture('success.json'));
    final tResp = BaseModel<String>(success: tJson['success']);

    test(
      "should return a BaseModel<String> when call to repo is succeed",
      () async {
        //arrange
        when(repository.addOffer(any)).thenAnswer((_) async => Right(tResp));
        //act
        final result = await sut.addOffer(tParams);
        //assert
        expect(result, Right(tResp));
        verify(repository.addOffer(tParams));
        verifyNoMoreInteractions(repository);
      },
    );

    test(
      "should return a ServerFailure when  repo return it",
      () async {
        //arrange
        when(repository.addOffer(any)).thenAnswer(
            (_) async => Left(ServerFailure(message: noInternetConnection)));
        //act
        final result = await sut.addOffer(tParams);
        //assert
        expect(result, Left(ServerFailure(message: noInternetConnection)));
        verify(repository.addOffer(tParams));
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
