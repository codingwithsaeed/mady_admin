import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/seller/data/datasources/seller_remote_source.dart';
import 'package:mady_admin/features/seller/data/models/seller_model.dart';
import 'package:mady_admin/features/seller/domain/entities/add_seller.dart';
import 'package:mady_admin/features/seller/domain/entities/seller.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'seller_remote_source_impl_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late SellerRemoteSourceImpl sut;
  late MockClient client;

  setUp(() {
    client = MockClient();
    sut = SellerRemoteSourceImpl(client: client);
  });

  group('Testing get sellers list', () {
    final url = Uri.parse('http://192.168.1.2/mady/webservice_admin.php');
    const tParams = Params({'action': 'get_sellers_list'});

    final tSellersList1 = [
      const Seller(
          sid: "6",
          storeName: "9 عطر آویشن",
          phone: "+989136581822",
          category: "ATARI",
          address: "2 اصفهان - میدان سهروردی",
          website: "www.avishan.co",
          logo: "http://192.168.1.2/mady/uploads/logo/avish.jpg",
          lat: "32",
          lng: "51",
          pocket: "1",
          offerCount: "3",
          expire: "1400-12-23",
          hasSpecial: "0",
          specialCount: "0"),
      const Seller(
          sid: "5",
          storeName: "8 عطر آویشن",
          phone: "+989136581821",
          category: "ATARI",
          address: "اصفهان - میدان سهروردی",
          website: "www.avishan.co",
          logo: "http://192.168.1.2/mady/uploads/logo/avish.jpg",
          lat: "32",
          lng: "51",
          pocket: "1",
          offerCount: "3",
          expire: "1400-12-23",
          hasSpecial: "0",
          specialCount: "0")
    ];

    final tSellerModel1 = SellerModel(success: 1, data: tSellersList1);
    const tSellerModel2 = SellerModel(success: 1, data: []);
    test(
      "Should perform a post reuqest with proper data",
      () async {
        when(client.post(any, body: anyNamed('body'))).thenAnswer(
            (_) async => http.Response(fixture('get_sellers.json'), 200));
        //act
        await sut.getSellers(tParams.param);
        //assert
        verify(client.post(url, body: tParams.param));
      },
    );

    test(
      "Should return List<Seller> when call to api is success 200",
      () async {
        when(client.post(any, body: anyNamed('body'))).thenAnswer(
            (_) async => http.Response(fixture('get_sellers.json'), 200));
        //act
        final result = await sut.getSellers(tParams.param);
        //assert
        expect(result, tSellerModel1);
      },
    );

    test(
      "Should return EmptyList<Seller> when call to api is success 200",
      () async {
        when(client.post(any, body: anyNamed('body'))).thenAnswer(
            (_) async => http.Response(fixture('get_sellers_empty.json'), 200));
        //act
        final result = await sut.getSellers(tParams.param);
        //assert
        expect(result, tSellerModel2);
      },
    );

    test(
      "Should throw a ServerException when api call isn't success 200",
      () async {
        when(client.post(any, body: anyNamed('body'))).thenAnswer(
            (_) async => http.Response(fixture('get_sellers_empty.json'), 404));
        //act
        final result = sut.getSellers;
        //assert
        expect(result(tParams.param),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group('Testing insertSeller', () {
    final url = Uri.parse('http://192.168.1.2/mady/webservice_admin.php');
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
      "Should perform a post reuqest with proper data",
      () async {
        when(client.post(any, body: anyNamed('body'))).thenAnswer(
            (_) async => http.Response(fixture('success.json'), 200));
        //act
        await sut.insertSeller(tParams.toJson());
        //assert
        verify(client.post(url, body: tParams.toJson()));
      },
    );

    test(
      "Should return true when call to api is success 200",
      () async {
        when(client.post(any, body: anyNamed('body'))).thenAnswer(
            (_) async => http.Response(fixture('success.json'), 200));
        //act
        final result = await sut.insertSeller(tParams.toJson());
        //assert
        expect(result, true);
      },
    );

    test(
      "Should throw a ServerException when api call isn't success 200",
      () async {
        when(client.post(any, body: anyNamed('body'))).thenAnswer(
            (_) async => http.Response(fixture('failed.json'), 404));
        //act
        final result = sut.insertSeller;
        //assert
        expect(result(tParams.toJson()), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group('Testing upload logo', () {
    final url = Uri.parse('http://192.168.1.2/mady/webservice_admin.php');
    const tParams = Params({
      'action': 'upload_logo',
      'name': 'imageName',
      'image': 'gdfgdfgsdfgdfgsdgf'
    });

    test(
      "Should perform a post reuqest with proper data",
      () async {
        when(client.post(any, body: anyNamed('body'))).thenAnswer(
            (_) async => http.Response(fixture('success_logo.json'), 200));
        //act
        await sut.uploadLogo(tParams.param);
        //assert
        verify(client.post(url, body: tParams.param));
      },
    );

    test(
      "Should return true when call to api is success 200",
      () async {
        when(client.post(any, body: anyNamed('body'))).thenAnswer(
            (_) async => http.Response(fixture('success_logo.json'), 200));
        //act
        final result = await sut.uploadLogo(tParams.param);
        //assert
        expect(result, 'link');
      },
    );

    test(
      "Should throw a ServerException when api call isn't success 200",
      () async {
        when(client.post(any, body: anyNamed('body'))).thenAnswer(
            (_) async => http.Response(fixture('failed.json'), 404));
        //act
        final result = sut.uploadLogo;
        //assert
        expect(result(tParams.param),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
