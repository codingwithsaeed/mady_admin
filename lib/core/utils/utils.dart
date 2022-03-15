import 'dart:math';
import 'package:intl/intl.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

class Utils {
  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(Random().nextInt(_chars.length)),
      ));

  static String numberFormatter(String number) =>
      NumberFormat('#,###,000').format(double.parse(number));
}
