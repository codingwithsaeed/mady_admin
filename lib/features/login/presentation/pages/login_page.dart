import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mady_admin/core/network/network_info.dart';
import 'package:mady_admin/features/login/data/datasources/login_remote_datasource.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/login/domain/usecases/login_usecase.dart';
import 'package:mady_admin/features/login/presentation/cubit/login_cubit.dart';
import 'package:mady_admin/main_page.dart';
import 'package:mady_admin/routes/router.gr.dart';
import 'widgets/fa_text_field.dart';
import 'widgets/naterial_button.dart';
import 'package:auto_route/auto_route.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        LoginUsecase(
          LoginRepositoryImpl(
            dataSource: LoginRemoteDataSourceImpl(client: Client()),
            networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
          ),
        ),
      ),
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
            context.router.push(const MainRoute());
          } else if (state is ErrorState) {
            Navigator.of(context).pop();
            FocusManager.instance.primaryFocus!.unfocus();
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(fontFamily: 'Vazir'),
                ),
                duration: const Duration(seconds: 1),
                backgroundColor: Colors.red,
              ),
            );
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
