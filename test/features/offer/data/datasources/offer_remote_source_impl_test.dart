import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/offer/data/datasources/offer_remote_source.dart';
import 'package:mady_admin/features/offer/data/models/all_offers.dart';
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
        when(client.post(any, body: anyNamed('body'))).thenAnswer(
            (_) async => Response(fixture('all_offers.json'), 404));
        //act
        final result = sut.getAllOffers;
        //assert
        expect(result(tParams.param),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
