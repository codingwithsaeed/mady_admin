import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/seller/domain/entities/add_seller.dart';
import 'package:mady_admin/features/seller/domain/entities/seller.dart';
import 'package:mady_admin/features/seller/domain/repositories/seller_repository.dart';
import 'package:mady_admin/features/seller/domain/usecases/seller_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'seller_usecase_test.mocks.dart';

@GenerateMocks([SellerRepository])
void main() {
  late SellerUsecase sut;
  late MockSellerRepository repository;

  setUp(() {
    repository = MockSellerRepository();
    sut = SellerUsecase(repository);
  });

  group('Testing getSellers', () {
    const tParams = Params({'action': 'get_sellers_list'});
    final tSellersList = [
      Seller(
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
          specialCount: "0"),
      Seller(
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
    ];

    test(
      "Should return a List<Seller> if call to repo was succeed",
      () async {
        //arrange
        when(repository.getSellers(any))
            .thenAnswer((_) async => Right(tSellersList));
        //act
        final result = await sut.getSellers(tParams);
        //assert
        expect(result, Right(tSellersList));
      },
    );

    test(
      "Should return a ServerFailure if call to repo was unsucceed",
      () async {
        //arrange
        when(repository.getSellers(any)).thenAnswer(
            (_) async => Left(ServerFailure(message: NO_INTERNET_CONNECTION)));
        //act
        final result = await sut.getSellers(tParams);
        //assert
        expect(result, Left(ServerFailure(message: NO_INTERNET_CONNECTION)));
      },
    );
  });

  group('Testing insert seller', () {
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
      "Should return a [true] if call to repo was succeed",
      () async {
        //arrange
        when(repository.insertSeller(any))
            .thenAnswer((_) async => const Right(true));
        //act
        final result = await sut.insertSeller(tParams);
        //assert
        expect(result, const Right(true));
      },
    );

    test(
      "Should return a ServerFailure if call to repo was unsucceed",
      () async {
        //arrange
        when(repository.insertSeller(any)).thenAnswer(
            (_) async => Left(ServerFailure(message: NO_INTERNET_CONNECTION)));
        //act
        final result = await sut.insertSeller(tParams);
        //assert
        expect(result, Left(ServerFailure(message: NO_INTERNET_CONNECTION)));
      },
    );
  });

  group('Testing upload logo', () {
    const tParams = Params({
      'action': 'upload_logo',
      'name': 'imageName',
      'image': 'gdfgdfgsdfgdfgsdgf'
    });

    test(
      "Should return a [true] if call to repo was succeed",
      () async {
        //arrange
        when(repository.uploadLogo(any))
            .thenAnswer((_) async => const Right('link'));
        //act
        final result = await sut.uploadLogo(tParams);
        //assert
        expect(result, const Right('link'));
      },
    );

    test(
      "Should return a ServerFailure if call to repo was unsucceed",
      () async {
        //arrange
        when(repository.uploadLogo(any)).thenAnswer(
            (_) async => Left(ServerFailure(message: NO_INTERNET_CONNECTION)));
        //act
        final result = await sut.uploadLogo(tParams);
        //assert
        expect(result, Left(ServerFailure(message: NO_INTERNET_CONNECTION)));
      },
    );
  });
}
