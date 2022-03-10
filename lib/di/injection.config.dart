// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i4;

import '../core/network/network_info.dart' as _i6;
import '../core/utils/injectable_modules.dart' as _i21;
import '../features/login/data/datasources/login_remote_datasource.dart' as _i5;
import '../features/login/data/repositories/login_repository_impl.dart' as _i16;
import '../features/login/domain/repositories/login_repository.dart' as _i15;
import '../features/login/domain/usecases/login_usecase.dart' as _i17;
import '../features/login/presentation/cubit/login_cubit.dart' as _i20;
import '../features/request/data/datasources/request_remote_datasource.dart'
    as _i7;
import '../features/request/data/repositories/request_repository_impl.dart'
    as _i9;
import '../features/request/domain/repositories/request_repository.dart' as _i8;
import '../features/request/domain/usecases/request_usecase.dart' as _i10;
import '../features/request/presentation/cubit/request_cubit.dart' as _i18;
import '../features/seller/data/datasources/seller_remote_source.dart' as _i11;
import '../features/seller/data/repositories/seller_repository_impl.dart'
    as _i13;
import '../features/seller/domain/repositories/seller_repository.dart' as _i12;
import '../features/seller/domain/usecases/seller_usecase.dart' as _i14;
import '../features/seller/presentation/cubit/seller_cubit.dart'
    as _i19; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final injectableModules = _$InjectableModules();
  gh.factory<_i3.Client>(() => injectableModules.client);
  gh.factory<_i4.InternetConnectionChecker>(() => injectableModules.checker);
  gh.factory<_i5.LoginRemoteDataSource>(
      () => _i5.LoginRemoteDataSourceImpl(client: get<_i3.Client>()));
  gh.factory<_i6.NetworkInfo>(
      () => _i6.NetworkInfoImpl(get<_i4.InternetConnectionChecker>()));
  gh.factory<_i7.RequestRemoteSource>(
      () => _i7.RequestRemoteSourceImpl(client: get<_i3.Client>()));
  gh.factory<_i8.RequestRepository>(() => _i9.RequestRepositoryImpl(
      dataSource: get<_i7.RequestRemoteSource>(),
      networkInfo: get<_i6.NetworkInfo>()));
  gh.factory<_i10.RequestUsecase>(
      () => _i10.RequestUsecase(get<_i8.RequestRepository>()));
  gh.factory<_i11.SellerRemoteSource>(
      () => _i11.SellerRemoteSourceImpl(client: get<_i3.Client>()));
  gh.factory<_i12.SellerRepository>(() => _i13.SellerRepositoryImpl(
      dataSource: get<_i11.SellerRemoteSource>(),
      networkInfo: get<_i6.NetworkInfo>()));
  gh.factory<_i14.SellerUsecase>(
      () => _i14.SellerUsecase(get<_i12.SellerRepository>()));
  gh.factory<_i15.LoginRepository>(() => _i16.LoginRepositoryImpl(
      dataSource: get<_i5.LoginRemoteDataSource>(),
      networkInfo: get<_i6.NetworkInfo>()));
  gh.factory<_i17.LoginUsecase>(
      () => _i17.LoginUsecase(get<_i15.LoginRepository>()));
  gh.factory<_i18.RequestCubit>(
      () => _i18.RequestCubit(get<_i10.RequestUsecase>()));
  gh.factory<_i19.SellerCubit>(
      () => _i19.SellerCubit(get<_i14.SellerUsecase>()));
  gh.factory<_i20.LoginCubit>(() => _i20.LoginCubit(get<_i17.LoginUsecase>()));
  return get;
}

class _$InjectableModules extends _i21.InjectableModules {}
