// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/utils/show_loading.dart';
import 'package:mady_admin/core/utils/show_snackbar.dart';
import 'package:mady_admin/features/login/presentation/cubit/login_cubit.dart';
import 'package:mady_admin/injection.dart';
import 'package:mady_admin/main_page.dart';
import 'widgets/fa_text_field.dart';
import 'widgets/naterial_button.dart';


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
        centerTitle: true,
        title: const Text('مادی برای ادمین'),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LodingState) {
            FocusManager.instance.primaryFocus!.unfocus();
            showLoading(context);
          } else if (state is LoadedState) {
            FocusManager.instance.primaryFocus!.unfocus();
            Navigator.of(context).pop();
            Navigator.pushNamed(context, MainPage.id);
          } else if (state is ErrorState) {
            Navigator.of(context).pop();
            FocusManager.instance.primaryFocus!.unfocus();
            showSnackbar(context, state.message);
          }
        },
        builder: (context, state) {
          return buildColumn(context);
        },
      ),
    );
  }

  Widget buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: Image.asset('assets/images/sale.png'),
        ),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FaTextField(
                icon: Icons.person_pin,
                hint: 'نام کاربری',
                onChanged: (value) {
                  username = value;
                },
              ),
              FaTextField(
                icon: Icons.password_outlined,
                hint: 'گذر واژه',
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              NaterialButton(
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
