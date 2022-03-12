import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SplashDataSource {
  /// Uses a shared prefrences to determine if user is logged in
  /// Throws a [SharedException] on all errors
  bool? checkIsUserLoggedIn();
}

@Injectable(as: SplashDataSource)
class SplashDataSourceImpl implements SplashDataSource {
  final SharedPreferences _sharedPreferences;

  SplashDataSourceImpl(this._sharedPreferences);

  @override
  bool? checkIsUserLoggedIn() {
    final result = _sharedPreferences.getBool('LOGIN');
    if (result != null) return result;
    throw const SharedException(message: notFoundException);
  }
}
