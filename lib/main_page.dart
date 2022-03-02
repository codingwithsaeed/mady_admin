import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mady_admin/routes/router.gr.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainPage extends StatelessWidget {
  static const String id = 'MAIN_PAGE';
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      appBarBuilder: (_, tabsRouter) => AppBar(
        automaticallyImplyLeading: false,
        title: const Text('مادی ادمین'),
        centerTitle: true,
      ),
      routes: const [
        RequestsRouter(),
        SellersRouter(),
        OffersRouter(),
        SettingsRouter()
      ],
      bottomNavigationBuilder: (_, tabsRouter) => SalomonBottomBar(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        currentIndex: tabsRouter.activeIndex,
        onTap: tabsRouter.setActiveIndex,
        items: [
          SalomonBottomBarItem(
            selectedColor: Colors.red,
            unselectedColor: Colors.red.shade100,
            icon: const Icon(
              Icons.request_page,
              size: 20.0,
            ),
            title: const Text(
              'Requests',
              style: TextStyle(fontFamily: 'Vazir'),
            ),
          ),
          SalomonBottomBarItem(
            selectedColor: Colors.red,
            unselectedColor: Colors.red.shade100,
            icon: const Icon(
              Icons.person,
              size: 20.0,
            ),
            title: const Text(
              'Sellers',
              style: TextStyle(fontFamily: 'Vazir'),
            ),
          ),
          SalomonBottomBarItem(
            selectedColor: Colors.red,
            unselectedColor: Colors.red.shade100,
            icon: const Icon(
              Icons.local_offer,
              size: 20.0,
            ),
            title: const Text(
              'Offers',
              style: TextStyle(fontFamily: 'Vazir'),
            ),
          ),
          SalomonBottomBarItem(
            selectedColor: Colors.red,
            unselectedColor: Colors.red.shade100,
            icon: const Icon(
              Icons.settings,
              size: 20.0,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(fontFamily: 'Vazir'),
            ),
          ),
        ],
      ),
    );
  }
}
