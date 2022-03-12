import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/network/network_info.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/seller/data/datasources/seller_remote_source.dart';
import 'package:mady_admin/features/seller/data/models/seller_model.dart';
import 'package:mady_admin/features/seller/data/repositories/seller_repository_impl.dart';
import 'package:mady_admin/features/seller/domain/entities/add_seller.dart';
import 'package:mady_admin/features/seller/domain/entities/seller.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'seller_repository_impl_test.mocks.dart';

@GenerateMocks([SellerRemoteSource, NetworkInfo])
void main() {
  late SellerRepositoryImpl sut;
  late MockNetworkInfo networkInfo;
  late MockSellerRemoteSource dataSource;
  setUp(() {
    networkInfo = MockNetworkInfo();
    dataSource = MockSellerRemoteSource();
    sut =
        SellerRepositoryImpl(dataSource: dataSource, networkInfo: networkInfo);
  });

  group('Testing get sellers list', () {
    const tParams = Params({'action': 'get_sellers_list'});

    final tSellersList1 = [
      const Seller(
          sid: "2",
          storeName: "2 عطر آویشن",
          phone: "+989136581815",
          category: "ATARI",
          address: "اصفهان - میدان سهروردی",
          website: "www.avishan.co",
          logo: "http://192.168.1.2/mady/uploads/logo/avish.jpg",
          lat: "32.646472",
          lng: "51.667644",
          pocket: "1",
          offerCount: "3",
          expire: "1400-12-23",
          hasSpecial: "0",
          specialCount: "0"),
      const Seller(
          sid: "1",
          storeName: "عطر آویشن",
          phone: "+989136581814",
          category: "ATARI",
          address: "اصفهان - میدان انقلاب",
          website: "www.avishan.co",
          logo: "http://192.168.1.2/mady/uploads/logo/avish.jpg",
          lat: "32.646472",
          lng: "51.667644",
          pocket: "1",
          offerCount: "3",
          expire: "1400-12-22",
          hasSpecial: "0",
          specialCount: "0")
    ];
    const tSellersList2 = <Seller>[];
    final tSellerModel1 = SellerModel(success: 1, data: tSellersList1);
    const tSellerModel2 = SellerModel(success: 1, data: []);
    test(
      "Should return a [ServerFailure] if device is not connected to internet",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(dataSource.getSellers(any)).thenAnswer((_) async => tSellerModel1);
        //act
        final result = await sut.getSellers(tParams);
        //assert
        expect(result, Left(ServerFailure(message: noInternetConnection)));
        verify(networkInfo.isConnected);
        verifyNoMoreInteractions(networkInfo);
      },
    );

    test(
      "Should return a List<Seller> if device is online and call to remote was succeed",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.getSellers(any)).thenAnswer((_) async => tSellerModel1);
        //act
        final result = await sut.getSellers(tParams);
        //assert
        expect(result, Right(tSellersList1));
        verify(dataSource.getSellers(tParams.param));
        verifyNoMoreInteractions(dataSource);
      },
    );

    test(
      "Should return a EmptyList<Seller> if device is online and call to remote was succeed",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.getSellers(any)).thenAnswer((_) async => tSellerModel2);
        //act
        final result = await sut.getSellers(tParams);
        //assert
        expect(result, const Right(tSellersList2));
        verify(dataSource.getSellers(tParams.param));
        verifyNoMoreInteractions(dataSource);
      },
    );

    test(
      "Should return a [ServerFailure] on ServerExceptions",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.getSellers(any))
            .thenThrow(ServerException(message: notFoundException));
        //act
        final result = await sut.getSellers(tParams);
        //assert
        expect(result, Left(ServerFailure(message: notFoundException)));
      },
    );
  });

  group('Testing insertSeller', () {
    final tParams = AddSeller(
        storeName: 'فروشگاه ۱',
        phone: '09139902080',
        category: 'ARAYESHI',
        address: 'اصفهان، میدان نقش جهان',
        logo: 'logo',
        lat: '32',
        lng: '51',
        pocket: '1');

    test(
      "Should return a [ServerFailure] if device is not connected to internet",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(dataSource.insertSeller(any)).thenAnswer((_) async => true);
        //act
        final result = await sut.insertSeller(tParams);
        //assert
        expect(result, Left(ServerFailure(message: noInternetConnection)));
        verify(networkInfo.isConnected);
        verifyNoMoreInteractions(networkInfo);
      },
    );

    test(
      "Should return true if device is online and call to remote was succeed",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.insertSeller(any)).thenAnswer((_) async => true);
        //act
        final result = await sut.insertSeller(tParams);
        //assert
        expect(result, const Right(true));
        verify(dataSource.insertSeller(tParams.toJson()));
        verifyNoMoreInteractions(dataSource);
      },
    );

    test(
      "Should return a [ServerFailure] on ServerExceptions",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.insertSeller(any))
            .thenThrow(ServerException(message: notFoundException));
        //act
        final result = await sut.insertSeller(tParams);
        //assert
        expect(result, Left(ServerFailure(message: notFoundException)));
      },
    );
  });

  group('Testing insertSeller', () {
    const tParams = Params({
      'action': 'upload_logo',
      'name': 'imageName',
      'image': 'gdfgdfgsdfgdfgsdgf'
    });

    test(
      "Should return a [ServerFailure] if device is not connected to internet",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(dataSource.uploadLogo(any)).thenAnswer((_) async => 'link');
        //act
        final result = await sut.uploadLogo(tParams);
        //assert
        expect(result, Left(ServerFailure(message: noInternetConnection)));
        verify(networkInfo.isConnected);
        verifyNoMoreInteractions(networkInfo);
      },
    );

    test(
      "Should return true if device is online and call to remote was succeed",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.uploadLogo(any)).thenAnswer((_) async => 'link');
        //act
        final result = await sut.uploadLogo(tParams);
        //assert
        expect(result, const Right('link'));
        verify(dataSource.uploadLogo(tParams.param));
        verifyNoMoreInteractions(dataSource);
      },
    );

    test(
      "Should return a [ServerFailure] on ServerExceptions",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.uploadLogo(any))
            .thenThrow(ServerException(message: notFoundException));
        //act
        final result = await sut.uploadLogo(tParams);
        //assert
        expect(result, Left(ServerFailure(message: notFoundException)));
      },
    );
  });
}
