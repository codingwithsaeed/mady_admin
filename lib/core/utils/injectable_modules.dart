import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

@module
abstract class InjectableModules {
  InternetConnectionChecker get checker => InternetConnectionChecker();
  http.Client get client => http.Client();
}
