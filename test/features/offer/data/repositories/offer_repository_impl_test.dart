import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/network/network_info.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/offer/data/datasources/offer_remote_source.dart';
import 'package:mady_admin/features/offer/data/models/all_offers.dart';
import 'package:mady_admin/features/offer/data/repositories/offer_repository_impl.dart';
import 'package:mady_admin/features/offer/domain/entities/offer.dart';
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
        expect(result, Left(ServerFailure(message: NO_INTERNET_CONNECTION)));
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
            .thenThrow(ServerException(message: NOT_FOUND_EX));
        //act
        final result = await sut.getAllOffers(tParams);
        //assert
        expect(result, Left(ServerFailure(message: NOT_FOUND_EX)));
      },
    );
  });
}
