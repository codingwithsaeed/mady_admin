// ignore_for_file: must_be_immutable, curly_braces_in_flow_control_structures
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mady_admin/core/utils/show_loading.dart';
import 'package:mady_admin/core/utils/show_snackbar.dart';
import 'package:mady_admin/core/x/x_widgets.dart';
import 'package:mady_admin/features/login/presentation/cubit/login_cubit.dart';
import 'package:mady_admin/di/injection.dart';
import 'package:mady_admin/main_page.dart';

class LoginPage extends StatelessWidget {
  static const String id = 'LoginPage';
  LoginPage({Key? key}) : super(key: key);

  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('مادی برای ادمین'),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: cubitListener,
        builder: (context, state) {
          return buildColumn(context);
        },
      ),
    );
  }

  void cubitListener(context, state) {
    FocusManager.instance.primaryFocus!.unfocus();
    if (state is LoginLoading)
      showLoading(context);
    else {
      Navigator.of(context).pop();
      if (state is LoginLoaded)
        Navigator.pushReplacementNamed(context, MainPage.id);
      if (state is LoginError) showSnackbar(context, message: state.message);
    }
  }

  Widget buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: Image.asset('assets/images/sale-red.png'),
        ),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              XHintTextField(
                icon: Icons.person_pin,
                hint: 'نام کاربری',
                onChanged: (value) {
                  username = value;
                },
              ),
              XHintTextField(
                icon: Icons.password_outlined,
                hint: 'گذر واژه',
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              XButton(
                title: 'ورود',
                onPressed: (() {
                  LoginCubit cubit = BlocProvider.of(context);
                  cubit.doAuth(username, password);
                }),
                color: Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
