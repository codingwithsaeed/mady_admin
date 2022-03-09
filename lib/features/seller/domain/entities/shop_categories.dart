import 'package:flutter/material.dart';

class Consts {
  static const List<DropdownMenuItem<String>> _categories = [
    DropdownMenuItem(child: Text("تره‌بار"), value: "تره‌بار"),
    DropdownMenuItem(child: Text("خوار‌و‌بار"), value: "خوار‌و‌بار"),
    DropdownMenuItem(
        child: Text("رستوران و فست‌فود"), value: "رستوران و فست‌فود"),
    DropdownMenuItem(child: Text("سوپر‌گوشت"), value: "سوپر‌گوشت"),
    DropdownMenuItem(child: Text("سوپر‌مارکت"), value: "سوپر‌مارکت"),
    DropdownMenuItem(child: Text("عطاری"), value: "عطاری"),
    DropdownMenuItem(child: Text("نان‌فانتزی"), value: "نان‌فانتزی"),
    DropdownMenuItem(child: Text("قنادی"), value: "قنادی"),
    DropdownMenuItem(child: Text("گل‌فروشی"), value: "گل‌فروشی"),
    DropdownMenuItem(child: Text("لبنیات"), value: "لبنیات"),
    DropdownMenuItem(child: Text("لوازم‌آرایشی"), value: "لوازم‌آرایشی"),
  ];

  static List<DropdownMenuItem<String>> get categories => _categories;

  static const List<DropdownMenuItem<String>> _pockets = [
    DropdownMenuItem(child: Text("یک روزه، یک آگهی"), value: "0"),
    DropdownMenuItem(child: Text("هفت روزه، سه آگهی"), value: "1"),
    DropdownMenuItem(child: Text("یک ماهه، ده آگهی"), value: "2"),
    DropdownMenuItem(child: Text("سه ماهه، پنجاه آگهی"), value: "3"),
    DropdownMenuItem(child: Text("شش ماهه، صدوبیست آگهی"), value: "4"),
    DropdownMenuItem(child: Text("یک روزه ويژه، یک آگهی"), value: "5"),
    DropdownMenuItem(child: Text("هفت روزه ويژه، دو آگهی"), value: "6"),
    DropdownMenuItem(child: Text("یک ماهه ويژه، پنج آگهی"), value: "7"),
    DropdownMenuItem(child: Text("سه ماهه ويژه، پانزده آگهی"), value: "8"),
    DropdownMenuItem(child: Text("شش ماهه ويژه، سی آگهی"), value: "9"),
  ];

  static List<DropdownMenuItem<String>> get pockets => _pockets;
}
