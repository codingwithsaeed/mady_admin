import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mady_admin/core/network/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl sut;
  late MockInternetConnectionChecker connectionChecker;

  setUp(() {
    connectionChecker = MockInternetConnectionChecker();
    sut = NetworkInfoImpl(connectionChecker);
  });

  test(
    "Should Forward call to InternetConnectionChecker.HasConection",
    () async {
      //arrange
      final futureRes = Future.value(true);
      when(connectionChecker.hasConnection).thenAnswer((_) => futureRes);
      //act
      final result = sut.isConnected;
      //assert
      expect(result, futureRes);
      verify(connectionChecker.hasConnection);
      verifyNoMoreInteractions(connectionChecker);
    },
  );
}
