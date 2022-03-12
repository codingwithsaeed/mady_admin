import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/features/splash/data/datasources/splash_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_datasource_impl_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences sharedPreferences;
  late SplashDataSourceImpl sut;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    sut = SplashDataSourceImpl(sharedPreferences);
  });

  group('Testing is user logged in', () {
    test(
      "Should return [SharedException] if there is no key with ['login'] value",
      () {
        //arrange
        when(sharedPreferences.getBool(any)).thenAnswer((_) => null);
        //act
        final result = sut.checkIsUserLoggedIn;
        //assert
        expect(result, throwsA(const TypeMatcher<SharedException>()));
      },
    );
  });
}
