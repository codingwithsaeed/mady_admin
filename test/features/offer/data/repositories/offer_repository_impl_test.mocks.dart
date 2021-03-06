// Mocks generated by Mockito 5.1.0 from annotations
// in mady_admin/test/features/offer/data/repositories/offer_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mady_admin/core/models/base_model.dart' as _i2;
import 'package:mady_admin/core/network/network_info.dart' as _i6;
import 'package:mady_admin/features/offer/data/datasources/offer_remote_source.dart'
    as _i3;
import 'package:mady_admin/features/offer/domain/entities/offer.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeBaseModel_0<Type> extends _i1.Fake implements _i2.BaseModel<Type> {}

/// A class which mocks [OfferRemoteSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockOfferRemoteSource extends _i1.Mock implements _i3.OfferRemoteSource {
  MockOfferRemoteSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i5.Offer>> getAllOffers(Map<String, dynamic>? params) =>
      (super.noSuchMethod(Invocation.method(#getAllOffers, [params]),
              returnValue: Future<List<_i5.Offer>>.value(<_i5.Offer>[]))
          as _i4.Future<List<_i5.Offer>>);
  @override
  _i4.Future<_i2.BaseModel<String>> addOffer(Map<String, dynamic>? params) =>
      (super.noSuchMethod(Invocation.method(#addOffer, [params]),
              returnValue: Future<_i2.BaseModel<String>>.value(
                  _FakeBaseModel_0<String>()))
          as _i4.Future<_i2.BaseModel<String>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i6.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
}
