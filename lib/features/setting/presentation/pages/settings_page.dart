import 'package:flutter/material.dart';
import 'package:mady_admin/core/x/widgets/x_button.dart';
import 'package:mady_admin/di/injection.dart';
import 'package:mady_admin/features/login/presentation/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              'تو ورژن های بعدی ایشالا',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),
            ),
          ),
          XButton(
            color: Colors.red,
            onPressed: () {
              getIt<SharedPreferences>().setBool('LOGIN', false);
              Navigator.pushReplacementNamed(context, LoginPage.id);
            },
            title: 'خروج از حساب کاربری',
            fontSize: 16.0,
          ),
        ],
      ),
    );
  }
}
