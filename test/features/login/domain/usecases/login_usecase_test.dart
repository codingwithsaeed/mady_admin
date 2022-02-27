import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/domain/entities/admin.dart';
import 'package:mady_admin/features/login/domain/repositories/login_repository.dart';
import 'package:mady_admin/features/login/domain/usecases/login_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  late LoginUsecase usecase;
  late MockLoginRepository repository;

  setUp(() {
    repository = MockLoginRepository();
    usecase = LoginUsecase(repository);
  });

  String username = 'saeed';
  String password = 'saeed';
  Params params = Params({'username': username, 'password': password});
  Admin admin = Admin('1', username);

  test(
    "should get admin from repository",
    () async {
      //arrange
      when(repository.authenticate(any)).thenAnswer((_) async => Right(admin));

      //act
      final result = await usecase(params);

      //assert
      expect(result, Right(admin));
      verify(repository.authenticate(params));
      verifyNoMoreInteractions(repository);
    },
  );
}
