import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/presentation/cubit/login_cubit.dart';
import 'package:mady_admin/features/login/presentation/pages/main_page.dart';
import 'widgets/fa_text_field.dart';
import 'widgets/naterial_button.dart';

class LoginPage extends StatelessWidget {
  static const String id = 'LOGIN_PAGE';
  LoginPage({Key? key}) : super(key: key);

   String? username;
   String? password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('مادی برای ادمین'),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LodingState) {
          
            showLoading(context);
          } else if (state is LoadedState) {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, MainPage.id);
          } else if (state is ErrorState) {
            Navigator.of(context).pop();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ));
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
                  cubit.doAuth(username!, password!);
                }),
                color: Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<dynamic> showLoading(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.red.withOpacity(0.1),
            insetPadding: const EdgeInsets.all(0.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SpinKitThreeBounce(
                color: Colors.red.shade900,
                size: 50.0,
              ),
            ),
          );
        });
  }
}
