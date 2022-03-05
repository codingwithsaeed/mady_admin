import 'package:flutter/material.dart';
import 'package:mady_admin/features/offer/presentation/pages/offers_page.dart';
import 'package:mady_admin/features/request/presentation/pages/requests_page.dart';
import 'package:mady_admin/features/seller/presentation/pages/sellers_page.dart';
import 'package:mady_admin/features/setting/presentation/pages/settings_page.dart';

class MainPage extends StatefulWidget {
  static const String id = 'MAIN_PAGE';
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pages = const <Widget>[
    RequestsPage(),
    SellersPage(),
    OffersPage(),
    SettingsPage()
  ];

  final navBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.request_page),
      label: 'درخواست ها',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_pin),
      label: 'فروشندگان',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sell),
      label: 'آفرها',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'تنظیمات',
    ),
  ];

  int _selectedIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(navBarItems[_selectedIndex].label!),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: PageView(
        controller: _controller,
        children: _pages,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: navBarItems,
        currentIndex: _selectedIndex,
        onTap: onItemTap,
      ),
    );
  }

  void onItemTap(index) {
    setState(() {
      _selectedIndex = index;
    });
    _controller.jumpToPage(index);
  }

  void onPageChanged(index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
