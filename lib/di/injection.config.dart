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
import '../core/utils/injectable_modules.dart' as _i26;
import '../features/login/data/datasources/login_remote_datasource.dart' as _i5;
import '../features/login/data/repositories/login_repository_impl.dart' as _i20;
import '../features/login/domain/repositories/login_repository.dart' as _i19;
import '../features/login/domain/usecases/login_usecase.dart' as _i21;
import '../features/login/presentation/cubit/login_cubit.dart' as _i25;
import '../features/offer/data/datasources/offer_remote_source.dart' as _i7;
import '../features/offer/data/repositories/offer_repository_impl.dart' as _i9;
import '../features/offer/domain/repositories/offer_repository.dart' as _i8;
import '../features/offer/domain/usecases/offer_usecase.dart' as _i10;
import '../features/offer/presentation/cubit/offer_cubit.dart' as _i22;
import '../features/request/data/datasources/request_remote_datasource.dart'
    as _i11;
import '../features/request/data/repositories/request_repository_impl.dart'
    as _i13;
import '../features/request/domain/repositories/request_repository.dart'
    as _i12;
import '../features/request/domain/usecases/request_usecase.dart' as _i14;
import '../features/request/presentation/cubit/request_cubit.dart' as _i23;
import '../features/seller/data/datasources/seller_remote_source.dart' as _i15;
import '../features/seller/data/repositories/seller_repository_impl.dart'
    as _i17;
import '../features/seller/domain/repositories/seller_repository.dart' as _i16;
import '../features/seller/domain/usecases/seller_usecase.dart' as _i18;
import '../features/seller/presentation/cubit/seller_cubit.dart'
    as _i24; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i7.OfferRemoteSource>(
      () => _i7.OfferRemoteSourceImpl(client: get<_i3.Client>()));
  gh.factory<_i8.OfferRepository>(() => _i9.OfferRepositoryImpl(
      get<_i7.OfferRemoteSource>(), get<_i6.NetworkInfo>()));
  gh.factory<_i10.OfferUsecase>(
      () => _i10.OfferUsecase(get<_i8.OfferRepository>()));
  gh.factory<_i11.RequestRemoteSource>(
      () => _i11.RequestRemoteSourceImpl(client: get<_i3.Client>()));
  gh.factory<_i12.RequestRepository>(() => _i13.RequestRepositoryImpl(
      dataSource: get<_i11.RequestRemoteSource>(),
      networkInfo: get<_i6.NetworkInfo>()));
  gh.factory<_i14.RequestUsecase>(
      () => _i14.RequestUsecase(get<_i12.RequestRepository>()));
  gh.factory<_i15.SellerRemoteSource>(
      () => _i15.SellerRemoteSourceImpl(client: get<_i3.Client>()));
  gh.factory<_i16.SellerRepository>(() => _i17.SellerRepositoryImpl(
      dataSource: get<_i15.SellerRemoteSource>(),
      networkInfo: get<_i6.NetworkInfo>()));
  gh.factory<_i18.SellerUsecase>(
      () => _i18.SellerUsecase(get<_i16.SellerRepository>()));
  gh.factory<_i19.LoginRepository>(() => _i20.LoginRepositoryImpl(
      dataSource: get<_i5.LoginRemoteDataSource>(),
      networkInfo: get<_i6.NetworkInfo>()));
  gh.factory<_i21.LoginUsecase>(
      () => _i21.LoginUsecase(get<_i19.LoginRepository>()));
  gh.factory<_i22.OfferCubit>(() => _i22.OfferCubit(get<_i10.OfferUsecase>()));
  gh.factory<_i23.RequestCubit>(
      () => _i23.RequestCubit(get<_i14.RequestUsecase>()));
  gh.factory<_i24.SellerCubit>(
      () => _i24.SellerCubit(get<_i18.SellerUsecase>()));
  gh.factory<_i25.LoginCubit>(() => _i25.LoginCubit(get<_i21.LoginUsecase>()));
  return get;
}

class _$InjectableModules extends _i26.InjectableModules {}
