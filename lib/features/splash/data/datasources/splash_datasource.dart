abstract class SplashDataSource {
  /// Uses a shared prefrences to determine if user is logged in
  /// Throws a [SharedException] on all errors
  Future<bool> checkIsUserLoggedIn();
}
