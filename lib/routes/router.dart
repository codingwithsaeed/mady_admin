import 'package:auto_route/auto_route.dart';
import 'package:mady_admin/features/login/presentation/pages/login_page.dart';
import 'package:mady_admin/features/offer/presentation/pages/offers_page.dart';
import 'package:mady_admin/features/offer/presentation/pages/single_offer_page.dart';
import 'package:mady_admin/features/request/presentation/pages/requests_page.dart';
import 'package:mady_admin/features/request/presentation/pages/single_request_page.dart';
import 'package:mady_admin/features/seller/presentation/pages/sellers_page.dart';
import 'package:mady_admin/features/seller/presentation/pages/single_seller_page.dart';
import 'package:mady_admin/features/setting/presentation/pages/settings_page.dart';
import 'package:mady_admin/main_page.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: [
  AutoRoute(
    path: 'main',
    page: MainPage,
    children: [
      AutoRoute(
        path: 'requests',
        name: 'RequestsRouter',
        page: EmptyRouterPage,
        children: [
          AutoRoute(path: '', page: RequestsPage),
          AutoRoute(path: ':requestId', page: SingleRequestPage),
        ],
      ),
      AutoRoute(
        path: 'sellers',
        name: 'SellersRouter',
        page: EmptyRouterPage,
        children: [
          AutoRoute(path: '', page: SellersPage),
          AutoRoute(path: ':sellerId', page: SingleSellerPage),
        ],
      ),
      AutoRoute(
        path: 'offers',
        name: 'OffersRouter',
        page: EmptyRouterPage,
        children: [
          AutoRoute(path: '', page: OffersPage),
          AutoRoute(path: ':offerId', page: SingleOfferPage),
        ],
      ),
      AutoRoute(
        path: 'settings',
        name: 'SettingsRouter',
        page: SettingsPage,
      ),
    ],
  ),
  AutoRoute(path: '/', page: LoginPage)
])
class $AppRouter {}
