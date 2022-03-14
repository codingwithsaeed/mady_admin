import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mady_admin/features/login/presentation/pages/login_page.dart';
import 'package:mady_admin/features/offer/presentation/pages/add_offer_page.dart';
import 'package:mady_admin/features/offer/presentation/pages/single_offer_page.dart';
import 'package:mady_admin/features/request/presentation/pages/single_request_page.dart';
import 'package:mady_admin/features/seller/presentation/pages/add_seller_page.dart';
import 'package:mady_admin/features/seller/presentation/pages/select_address_page.dart';
import 'package:mady_admin/features/splash/presentation/pages/splash_page.dart';
import 'package:mady_admin/main_page.dart';
import 'di/injection.dart';
import 'features/seller/presentation/pages/single_seller_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa'), // Farsi, no country code
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Vazir',
      ),
      initialRoute: SplashPage.id,
      routes: {
        SplashPage.id: (context) => const SplashPage(),
        MainPage.id: (context) => const MainPage(),
        LoginPage.id: (context) => const LoginPage(),
        SingleRequestPage.id: (context) => const SingleRequestPage(),
        SingleSellerPage.id: (context) => const SingleSellerPage(),
        AddSellerPage.id: (context) => const AddSellerPage(),
        SellectAddressPage.id: (context) => const SellectAddressPage(),
        AddOfferPage.id: (context) => const AddOfferPage(),
        SingleOfferPage.id: (context) => const SingleOfferPage()
      },
    );
  }
}
