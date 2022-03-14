import 'package:flutter/material.dart';

class Consts {
  static const _online =
      'https://codingwithsaeed.ir/api/mady/webservice_admin.php';

  static const _local = 'http://192.168.1.2/mady/webservice_admin.php';

  static Uri get currentUrl => Uri.parse(_local);

  static const List<String> _pocketTitles = [
    "یک روزه، یک آگهی",
    "هفت روزه، سه آگهی",
    "یک ماهه، ده آگهی",
    "سه ماهه، پنجاه آگهی",
    "شش ماهه، صدوبیست آگهی",
    "یک روزه ويژه، یک آگهی",
    "هفت روزه ويژه، دو آگهی",
    "یک ماهه ويژه، پنج آگهی",
    "سه ماهه ويژه، پانزده آگهی",
    "شش ماهه ويژه، سی آگهی"
  ];

  static List<String> get pocketTitles => _pocketTitles;

  static const List<String> _categoryTitles = [
    "تره‌بار",
    "خوار‌و‌بار",
    "رستوران و فست‌فود",
    "سوپر‌گوشت",
    "سوپر‌مارکت",
    "عطاری",
    "نان‌فانتزی",
    "قنادی",
    "گل‌فروشی",
    "لبنیات",
    "لوازم‌آرایشی",
  ];

  static List<String> get categoryTitles => _categoryTitles;

  static final List<DropdownMenuItem<String>> _categories = [
    DropdownMenuItem(child: Text(categoryTitles[0]), value: categoryTitles[0]),
    DropdownMenuItem(child: Text(categoryTitles[1]), value: categoryTitles[1]),
    DropdownMenuItem(child: Text(categoryTitles[2]), value: categoryTitles[2]),
    DropdownMenuItem(child: Text(categoryTitles[3]), value: categoryTitles[3]),
    DropdownMenuItem(child: Text(categoryTitles[4]), value: categoryTitles[4]),
    DropdownMenuItem(child: Text(categoryTitles[5]), value: categoryTitles[5]),
    DropdownMenuItem(child: Text(categoryTitles[6]), value: categoryTitles[6]),
    DropdownMenuItem(child: Text(categoryTitles[7]), value: categoryTitles[7]),
    DropdownMenuItem(child: Text(categoryTitles[8]), value: categoryTitles[8]),
    DropdownMenuItem(child: Text(categoryTitles[9]), value: categoryTitles[9]),
    DropdownMenuItem(
        child: Text(categoryTitles[10]), value: categoryTitles[10]),
  ];

  static List<DropdownMenuItem<String>> get categories => _categories;

  static final List<DropdownMenuItem<String>> _pockets = [
    DropdownMenuItem(child: Text(pocketTitles[0]), value: "0"),
    DropdownMenuItem(child: Text(pocketTitles[1]), value: "1"),
    DropdownMenuItem(child: Text(pocketTitles[2]), value: "2"),
    DropdownMenuItem(child: Text(pocketTitles[3]), value: "3"),
    DropdownMenuItem(child: Text(pocketTitles[4]), value: "4"),
    DropdownMenuItem(child: Text(pocketTitles[5]), value: "5"),
    DropdownMenuItem(child: Text(pocketTitles[6]), value: "6"),
    DropdownMenuItem(child: Text(pocketTitles[7]), value: "7"),
    DropdownMenuItem(child: Text(pocketTitles[8]), value: "8"),
    DropdownMenuItem(child: Text(pocketTitles[9]), value: "9"),
  ];

  static List<DropdownMenuItem<String>> get pockets => _pockets;

  static const List<String> _offerTypesTitle = ["معمولی", "ویژه"];

  static List<String> get offerTypesTitle => _offerTypesTitle;

  static final List<DropdownMenuItem<String>> offerTypes = [
    DropdownMenuItem(child: Text(offerTypesTitle[0]), value: "0"),
    DropdownMenuItem(child: Text(offerTypesTitle[1]), value: "1"),
  ];

  static const List<String> _offerStatusTitle = ["پیش نمایش برای فروشنده", "انتشار"];

  static List<String> get offerStatusTitle => _offerStatusTitle;

  static final List<DropdownMenuItem<String>> offerStatus = [
    DropdownMenuItem(child: Text(offerStatusTitle[0]), value: "0"),
    DropdownMenuItem(child: Text(offerStatusTitle[1]), value: "1"),
  ];
}
