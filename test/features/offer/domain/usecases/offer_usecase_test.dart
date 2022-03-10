import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/offer/domain/entities/category_offer.dart';
import 'package:mady_admin/features/offer/domain/entities/offer.dart';
import 'package:mady_admin/features/offer/domain/repositories/offer_repository.dart';
import 'package:mady_admin/features/offer/domain/usecases/offer_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
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

    const List<CategoryOffer> tOffers = [
      CategoryOffer(name: 'سوپرگوشت', success: 1, data: [
        Offer(
            date: "1400-12-19",
            eTime: "22:00",
            oid: "1",
            content:
                "\u06af\u0648\u0634\u062a \u0628\u0648\u0642\u0644\u0645\u0648\u0646",
            sTime: "10:30",
            price: "70000",
            percent: "50",
            currentPrice: "35000",
            picture: "http://192.168.1.2/mady/uploads/offerpics/meat.jpeg",
            count: "10",
            sid: "8",
            storeName:
                "\u0633\u0648\u067e\u0631\u06af\u0648\u0634\u062a \u0633\u0639\u06cc\u062f ",
            address:
                "\u0627\u0635\u0641\u0647\u0627\u0646 \u0645\u06cc\u062f\u0627\u0646 \u0627\u0645\u0627\u0645 ",
            website: "https://codingwithsaeed.ir",
            logo: "http://192.168.1.2/mady/uploads/logo/yzFtDk.jpeg",
            lat: "32.66759720557876",
            lng: "51.68581299483777",
            distance: "1.53")
      ]),
      CategoryOffer(name: 'سوپرمارکت', success: 1, data: [
        Offer(
            date: "1400-12-19",
            eTime: "22:00",
            oid: "2",
            content:
                "\u06af\u0648\u0634\u062a \u0628\u0648\u0642\u0644\u0645\u0648\u0646",
            sTime: "10:30",
            price: "70000",
            percent: "50",
            currentPrice: "35000",
            picture: "http://192.168.1.2/mady/uploads/offerpics/meat.jpeg",
            count: "10",
            sid: "8",
            storeName:
                "\u0633\u0648\u067e\u0631\u06af\u0648\u0634\u062a \u0633\u0639\u06cc\u062f ",
            address:
                "\u0627\u0635\u0641\u0647\u0627\u0646 \u0645\u06cc\u062f\u0627\u0646 \u0627\u0645\u0627\u0645 ",
            website: "https://codingwithsaeed.ir",
            logo: "http://192.168.1.2/mady/uploads/logo/yzFtDk.jpeg",
            lat: "32.66759720557876",
            lng: "51.68581299483777",
            distance: "1.53")
      ])
    ];
    test(
      "should return a List<CategoryOffer> when call to repo is succeed",
      () async {
        //arrange
        when(repository.getAllOffers(any))
            .thenAnswer((_) async => const Right(tOffers));
        //act
        final result = await sut.getAllOffers(tParams);
        //assert
        expect(result, const Right(tOffers));
        verify(repository.getAllOffers(tParams));
        verifyNoMoreInteractions(repository);
      },
    );

    test(
      "should return a ServerFailure when  repo return it",
      () async {
        //arrange
        when(repository.getAllOffers(any)).thenAnswer(
            (_) async => Left(ServerFailure(message: NO_INTERNET_CONNECTION)));
        //act
        final result = await sut.getAllOffers(tParams);
        //assert
        expect(result, Left(ServerFailure(message: NO_INTERNET_CONNECTION)));
        verify(repository.getAllOffers(tParams));
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
