import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mady_admin/core/network/network_info.dart';
import 'package:mady_admin/features/login/data/datasources/login_remote_datasource.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/login/domain/usecases/login_usecase.dart';
import 'package:mady_admin/features/login/presentation/cubit/login_cubit.dart';
import 'package:mady_admin/features/login/presentation/pages/login_page.dart';
import 'package:mady_admin/features/login/presentation/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => LoginCubit(
          LoginUsecase(
            LoginRepositoryImpl(
              dataSource: LoginRemoteDataSourceImpl(client: Client()),
              networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
            ),
          ),
        ),
        child: LoginPage(),
      ),
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Vazir',
      ),
      routes: {
        LoginPage.id: (context) => LoginPage(),
        MainPage.id: (context) => const MainPage(),
      },
    );
  }
}
