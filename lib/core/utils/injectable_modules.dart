import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class InjectableModules {
  InternetConnectionChecker get checker => InternetConnectionChecker();
  http.Client get client => http.Client();
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
