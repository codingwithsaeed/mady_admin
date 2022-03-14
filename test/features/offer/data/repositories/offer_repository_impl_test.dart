import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/models/base_model.dart';
import 'package:mady_admin/core/network/network_info.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/offer/data/datasources/offer_remote_source.dart';
import 'package:mady_admin/features/offer/data/models/all_offers.dart';
import 'package:mady_admin/features/offer/data/repositories/offer_repository_impl.dart';
import 'package:mady_admin/features/offer/domain/entities/add_offer.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'offer_repository_impl_test.mocks.dart';

@GenerateMocks([OfferRemoteSource, NetworkInfo])
void main() {
  late MockOfferRemoteSource dataSource;
  late MockNetworkInfo networkInfo;
  late OfferRepositoryImpl sut;

  setUp(() {
    dataSource = MockOfferRemoteSource();
    networkInfo = MockNetworkInfo();
    sut = OfferRepositoryImpl(dataSource, networkInfo);
  });

  group('Testing get all offers', () {
    const tParams = Params({'action': 'get_all_offers'});

    final AllOffers allOffers =
        AllOffers.fromJson(jsonDecode(fixture('all_offers.json')));

    test(
      "should reutrn ServerFailure if device is Offline",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(dataSource.getAllOffers(any))
            .thenAnswer((_) async => allOffers.offers);
        //act
        final result = await sut.getAllOffers(tParams);
        //assert
        expect(result, Left(ServerFailure(message: noInternetConnection)));
        verify(networkInfo.isConnected);
        verifyNoMoreInteractions(networkInfo);
      },
    );

    test(
      "should reutrn List<CategoryOffers> if device is online and call to datasource is succeed",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.getAllOffers(any))
            .thenAnswer((_) async => allOffers.offers);
        //act
        final result = await sut.getAllOffers(tParams);
        //assert
        expect(result, Right(allOffers.offers));
        verify(dataSource.getAllOffers(tParams.param));
        verifyNoMoreInteractions(dataSource);
      },
    );

    test(
      "should reutrn ServerFailure on ServerException from datasource",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.getAllOffers(any))
            .thenThrow(ServerException(message: notFoundException));
        //act
        final result = await sut.getAllOffers(tParams);
        //assert
        expect(result, Left(ServerFailure(message: notFoundException)));
      },
    );
  });

    group('Testing addOffer', () {
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
      "should reutrn ServerFailure if device is Offline",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(dataSource.addOffer(any))
            .thenAnswer((_) async => tResp);
        //act
        final result = await sut.addOffer(tParams);
        //assert
        expect(result, Left(ServerFailure(message: noInternetConnection)));
        verify(networkInfo.isConnected);
        verifyNoMoreInteractions(networkInfo);
      },
    );

    test(
      "should reutrn BaseModel<Stirng> if device is online and call to datasource is succeed",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.addOffer(any))
            .thenAnswer((_) async => tResp);
        //act
        final result = await sut.addOffer(tParams);
        //assert
        expect(result, Right(tResp));
        verify(dataSource.addOffer(tParams.param));
        verifyNoMoreInteractions(dataSource);
      },
    );

    test(
      "should reutrn ServerFailure on ServerException from datasource",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.addOffer(any))
            .thenThrow(ServerException(message: notFoundException));
        //act
        final result = await sut.addOffer(tParams);
        //assert
        expect(result, Left(ServerFailure(message: notFoundException)));
      },
    );
  });
}
