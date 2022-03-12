import 'package:flutter/material.dart';

class Consts {
  static const List<String> pocketsTitle = [
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

  static const List<String> categoryTitle = [
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

  static final List<DropdownMenuItem<String>> _categories = [
    DropdownMenuItem(child: Text(categoryTitle[0]), value: categoryTitle[0]),
    DropdownMenuItem(child: Text(categoryTitle[1]), value: categoryTitle[1]),
    DropdownMenuItem(child: Text(categoryTitle[2]), value: categoryTitle[2]),
    DropdownMenuItem(child: Text(categoryTitle[3]), value: categoryTitle[3]),
    DropdownMenuItem(child: Text(categoryTitle[4]), value: categoryTitle[4]),
    DropdownMenuItem(child: Text(categoryTitle[5]), value: categoryTitle[5]),
    DropdownMenuItem(child: Text(categoryTitle[6]), value: categoryTitle[6]),
    DropdownMenuItem(child: Text(categoryTitle[7]), value: categoryTitle[7]),
    DropdownMenuItem(child: Text(categoryTitle[8]), value: categoryTitle[8]),
    DropdownMenuItem(child: Text(categoryTitle[9]), value: categoryTitle[9]),
    DropdownMenuItem(child: Text(categoryTitle[10]), value: categoryTitle[10]),
  ];

  static List<DropdownMenuItem<String>> get categories => _categories;

  static final List<DropdownMenuItem<String>> _pockets = [
    DropdownMenuItem(child: Text(pocketsTitle[0]), value: "0"),
    DropdownMenuItem(child: Text(pocketsTitle[1]), value: "1"),
    DropdownMenuItem(child: Text(pocketsTitle[2]), value: "2"),
    DropdownMenuItem(child: Text(pocketsTitle[3]), value: "3"),
    DropdownMenuItem(child: Text(pocketsTitle[4]), value: "4"),
    DropdownMenuItem(child: Text(pocketsTitle[5]), value: "5"),
    DropdownMenuItem(child: Text(pocketsTitle[6]), value: "6"),
    DropdownMenuItem(child: Text(pocketsTitle[7]), value: "7"),
    DropdownMenuItem(child: Text(pocketsTitle[8]), value: "8"),
    DropdownMenuItem(child: Text(pocketsTitle[9]), value: "9"),
  ];

  static List<DropdownMenuItem<String>> get pockets => _pockets;
}
