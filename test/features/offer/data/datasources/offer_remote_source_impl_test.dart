import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/models/base_model.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/offer/data/datasources/offer_remote_source.dart';
import 'package:mady_admin/features/offer/data/models/all_offers.dart';
import 'package:mady_admin/features/offer/domain/entities/add_offer.dart';
import 'package:mady_admin/utils/consts.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'offer_remote_source_impl_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  late MockClient client;
  late OfferRemoteSourceImpl sut;

  setUp(() {
    client = MockClient();
    sut = OfferRemoteSourceImpl(client: client);
  });

  group('Testing get sellers list', () {
    final url = Uri.parse('http://192.168.1.2/mady/webservice_admin.php');
    const tParams = Params({'action': 'get_all_offers'});

    final allOffers =
        AllOffers.fromJson(jsonDecode(fixture('all_offers.json')));
    test(
      "Should perform a post reuqest with proper data",
      () async {
        when(client.post(any, body: anyNamed('body')))
            .thenAnswer((_) async => Response(fixture('all_offers.json'), 200));
        //act
        await sut.getAllOffers(tParams.param);
        //assert
        verify(client.post(url, body: tParams.param));
      },
    );

    test(
      "Should return List<CategoryOffer> when call to api is success 200",
      () async {
        when(client.post(any, body: anyNamed('body')))
            .thenAnswer((_) async => Response(fixture('all_offers.json'), 200));
        //act
        final result = await sut.getAllOffers(tParams.param);
        //assert
        expect(result, allOffers.offers);
      },
    );

    test(
      "Should throw a ServerException when api call isn't success 200",
      () async {
        when(client.post(any, body: anyNamed('body')))
            .thenAnswer((_) async => Response(fixture('all_offers.json'), 404));
        //act
        final result = sut.getAllOffers;
        //assert
        expect(result(tParams.param),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group('Testing AddOffer', () {
    final url = Consts.currentUrl;
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

    final tJsonSuccess = fixture('success.json');
    final tRespSuccess =
        BaseModel<String>(success: jsonDecode(tJsonSuccess)['success'], data: '');

    final tJsonMinus1 = fixture('success_minus1.json');

    final tJsonError = fixture('add_offer_error.json');

    test(
      "Should perform a post reuqest with proper data",
      () async {
        when(client.post(any, body: anyNamed('body')))
            .thenAnswer((_) async => Response(tJsonSuccess, 200));
        //act
        await sut.addOffer(tParams.param);
        //assert
        verify(client.post(url, body: tParams.param));
      },
    );

    test(
      "Should return BaseModel<String> when call to api is success 200",
      () async {
        when(client.post(any, body: anyNamed('body')))
            .thenAnswer((_) async => Response(tJsonSuccess, 200));
        //act
        final result = await sut.addOffer(tParams.param);
        //assert
        expect(result, tRespSuccess);
      },
    );

    test(
      "Should return ServerException when call to api is success 200 but answer in success -1",
      () async {
        when(client.post(any, body: anyNamed('body')))
            .thenAnswer((_) async => Response(tJsonMinus1, 200));
        //act
        final result = sut.addOffer;
        //assert
        expect(result(tParams.param),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );

    test(
      "Should return ServerException when call to api is success 200 but answer in success -2",
      () async {
        when(client.post(any, body: anyNamed('body')))
            .thenAnswer((_) async => Response(tJsonError, 200));
        //act
        final result = sut.addOffer;
        //assert
        expect(result(tParams.param),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );

    test(
      "Should throw a ServerException when api call isn't success 200",
      () async {
        when(client.post(any, body: anyNamed('body')))
            .thenAnswer((_) async => Response(fixture('success.json'), 404));
        //act
        final result = sut.addOffer;
        //assert
        expect(result(tParams.param),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
