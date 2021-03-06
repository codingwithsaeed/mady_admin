// Mocks generated by Mockito 5.1.0 from annotations
// in mady_admin/test/features/offer/domain/usecases/offer_usecase_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mady_admin/core/errors/failures.dart' as _i5;
import 'package:mady_admin/core/models/base_model.dart' as _i8;
import 'package:mady_admin/core/usecases/usecase.dart' as _i7;
import 'package:mady_admin/features/offer/domain/entities/offer.dart' as _i6;
import 'package:mady_admin/features/offer/domain/repositories/offer_repository.dart'
    as _i3;
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

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [OfferRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockOfferRepository extends _i1.Mock implements _i3.OfferRepository {
  MockOfferRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Offer>>> getAllOffers(
          _i7.Params? params) =>
      (super.noSuchMethod(Invocation.method(#getAllOffers, [params]),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Offer>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.Offer>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Offer>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i8.BaseModel<String>>> addOffer(
          _i7.Params? params) =>
      (super.noSuchMethod(Invocation.method(#addOffer, [params]),
              returnValue:
                  Future<_i2.Either<_i5.Failure, _i8.BaseModel<String>>>.value(
                      _FakeEither_0<_i5.Failure, _i8.BaseModel<String>>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i8.BaseModel<String>>>);
}
