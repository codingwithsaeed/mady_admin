// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mady_admin/core/utils/show_snackbar.dart';
import 'package:mady_admin/di/injection.dart';
import 'package:mady_admin/features/login/presentation/pages/login_page.dart';
import 'package:mady_admin/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:mady_admin/main_page.dart';

class SplashPage extends StatelessWidget {
  static const id = 'SplashPage';
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) => getIt<SplashCubit>(),
      child: const SplashPageImpl(),
    );
  }
}

class SplashPageImpl extends StatefulWidget {
  const SplashPageImpl({Key? key}) : super(key: key);

  @override
  State<SplashPageImpl> createState() => _SplashPageImplState();
}

class _SplashPageImplState extends State<SplashPageImpl> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      BlocProvider.of<SplashCubit>(context).checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    return Scaffold(
      backgroundColor: Colors.red,
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashError)
            showSnackbar(context,
                message: state.message,
                color: Colors.white,
                textColor: Colors.black);
          if (state is SplashLoggedIn)
            Navigator.pushReplacementNamed(context, MainPage.id);
          if (state is SplashNotLoggedIn)
            Navigator.pushReplacementNamed(context, LoginPage.id);
        },
        builder: (context, state) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 150,
                ),
                const Center(
                  child: Image(
                    width: 300,
                    height: 300,
                    image: AssetImage('assets/images/sale-white.png'),
                  ),
                ),
                if (state is SplashError)
                  buildErrorBody()
                else
                  buildLoadingBody(),
              ]);
        },
      ),
    );
  }

  Widget buildErrorBody() => TextButton(
        onPressed: () {
          BlocProvider.of<SplashCubit>(context).checkLogin();
        },
        child: const Text(
          'تلاش مجدد',
          style: TextStyle(color: Colors.white),
        ),
      );

  Widget buildLoadingBody() => const CircularProgressIndicator(
        color: Colors.white,
      );
}
