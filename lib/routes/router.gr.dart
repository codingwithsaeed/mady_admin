// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i11;

import '../features/login/presentation/pages/login_page.dart' as _i2;
import '../features/offer/presentation/pages/offers_page.dart' as _i9;
import '../features/offer/presentation/pages/single_offer_page.dart' as _i10;
import '../features/request/presentation/pages/requests_page.dart' as _i5;
import '../features/request/presentation/pages/single_request_page.dart' as _i6;
import '../features/seller/presentation/pages/sellers_page.dart' as _i7;
import '../features/seller/presentation/pages/single_seller_page.dart' as _i8;
import '../features/setting/presentation/pages/settings_page.dart' as _i4;
import '../main_page.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MainPage());
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.LoginPage(key: args.key));
    },
    RequestsRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    SellersRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    OffersRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    SettingsRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.SettingsPage());
    },
    RequestsRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.RequestsPage());
    },
    SingleRequestRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleRequestRouteArgs>(
          orElse: () => SingleRequestRouteArgs(
              requestId: pathParams.getInt('requestId')));
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i6.SingleRequestPage(key: args.key, requestId: args.requestId));
    },
    SellersRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.SellersPage());
    },
    SingleSellerRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleSellerRouteArgs>(
          orElse: () =>
              SingleSellerRouteArgs(sellerId: pathParams.getInt('sellerId')));
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i8.SingleSellerPage(key: args.key, sellerId: args.sellerId));
    },
    OffersRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.OffersPage());
    },
    SingleOfferRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleOfferRouteArgs>(
          orElse: () =>
              SingleOfferRouteArgs(offerId: pathParams.getInt('offerId')));
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i10.SingleOfferPage(key: args.key, offerId: args.offerId));
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(MainRoute.name, path: 'main', children: [
          _i3.RouteConfig(RequestsRouter.name,
              path: 'requests',
              parent: MainRoute.name,
              children: [
                _i3.RouteConfig(RequestsRoute.name,
                    path: '', parent: RequestsRouter.name),
                _i3.RouteConfig(SingleRequestRoute.name,
                    path: ':requestId', parent: RequestsRouter.name)
              ]),
          _i3.RouteConfig(SellersRouter.name,
              path: 'sellers',
              parent: MainRoute.name,
              children: [
                _i3.RouteConfig(SellersRoute.name,
                    path: '', parent: SellersRouter.name),
                _i3.RouteConfig(SingleSellerRoute.name,
                    path: ':sellerId', parent: SellersRouter.name)
              ]),
          _i3.RouteConfig(OffersRouter.name,
              path: 'offers',
              parent: MainRoute.name,
              children: [
                _i3.RouteConfig(OffersRoute.name,
                    path: '', parent: OffersRouter.name),
                _i3.RouteConfig(SingleOfferRoute.name,
                    path: ':offerId', parent: OffersRouter.name)
              ]),
          _i3.RouteConfig(SettingsRouter.name,
              path: 'settings', parent: MainRoute.name)
        ]),
        _i3.RouteConfig(LoginRoute.name, path: '/')
      ];
}

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i3.PageRouteInfo<void> {
  const MainRoute({List<_i3.PageRouteInfo>? children})
      : super(MainRoute.name, path: 'main', initialChildren: children);

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i3.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i11.Key? key})
      : super(LoginRoute.name, path: '/', args: LoginRouteArgs(key: key));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.EmptyRouterPage]
class RequestsRouter extends _i3.PageRouteInfo<void> {
  const RequestsRouter({List<_i3.PageRouteInfo>? children})
      : super(RequestsRouter.name, path: 'requests', initialChildren: children);

  static const String name = 'RequestsRouter';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class SellersRouter extends _i3.PageRouteInfo<void> {
  const SellersRouter({List<_i3.PageRouteInfo>? children})
      : super(SellersRouter.name, path: 'sellers', initialChildren: children);

  static const String name = 'SellersRouter';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class OffersRouter extends _i3.PageRouteInfo<void> {
  const OffersRouter({List<_i3.PageRouteInfo>? children})
      : super(OffersRouter.name, path: 'offers', initialChildren: children);

  static const String name = 'OffersRouter';
}

/// generated route for
/// [_i4.SettingsPage]
class SettingsRouter extends _i3.PageRouteInfo<void> {
  const SettingsRouter() : super(SettingsRouter.name, path: 'settings');

  static const String name = 'SettingsRouter';
}

/// generated route for
/// [_i5.RequestsPage]
class RequestsRoute extends _i3.PageRouteInfo<void> {
  const RequestsRoute() : super(RequestsRoute.name, path: '');

  static const String name = 'RequestsRoute';
}

/// generated route for
/// [_i6.SingleRequestPage]
class SingleRequestRoute extends _i3.PageRouteInfo<SingleRequestRouteArgs> {
  SingleRequestRoute({_i11.Key? key, required int requestId})
      : super(SingleRequestRoute.name,
            path: ':requestId',
            args: SingleRequestRouteArgs(key: key, requestId: requestId),
            rawPathParams: {'requestId': requestId});

  static const String name = 'SingleRequestRoute';
}

class SingleRequestRouteArgs {
  const SingleRequestRouteArgs({this.key, required this.requestId});

  final _i11.Key? key;

  final int requestId;

  @override
  String toString() {
    return 'SingleRequestRouteArgs{key: $key, requestId: $requestId}';
  }
}

/// generated route for
/// [_i7.SellersPage]
class SellersRoute extends _i3.PageRouteInfo<void> {
  const SellersRoute() : super(SellersRoute.name, path: '');

  static const String name = 'SellersRoute';
}

/// generated route for
/// [_i8.SingleSellerPage]
class SingleSellerRoute extends _i3.PageRouteInfo<SingleSellerRouteArgs> {
  SingleSellerRoute({_i11.Key? key, required int sellerId})
      : super(SingleSellerRoute.name,
            path: ':sellerId',
            args: SingleSellerRouteArgs(key: key, sellerId: sellerId),
            rawPathParams: {'sellerId': sellerId});

  static const String name = 'SingleSellerRoute';
}

class SingleSellerRouteArgs {
  const SingleSellerRouteArgs({this.key, required this.sellerId});

  final _i11.Key? key;

  final int sellerId;

  @override
  String toString() {
    return 'SingleSellerRouteArgs{key: $key, sellerId: $sellerId}';
  }
}

/// generated route for
/// [_i9.OffersPage]
class OffersRoute extends _i3.PageRouteInfo<void> {
  const OffersRoute() : super(OffersRoute.name, path: '');

  static const String name = 'OffersRoute';
}

/// generated route for
/// [_i10.SingleOfferPage]
class SingleOfferRoute extends _i3.PageRouteInfo<SingleOfferRouteArgs> {
  SingleOfferRoute({_i11.Key? key, required int offerId})
      : super(SingleOfferRoute.name,
            path: ':offerId',
            args: SingleOfferRouteArgs(key: key, offerId: offerId),
            rawPathParams: {'offerId': offerId});

  static const String name = 'SingleOfferRoute';
}

class SingleOfferRouteArgs {
  const SingleOfferRouteArgs({this.key, required this.offerId});

  final _i11.Key? key;

  final int offerId;

  @override
  String toString() {
    return 'SingleOfferRouteArgs{key: $key, offerId: $offerId}';
  }
}
