import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
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
  Admin admin = Admin(1, username);

  test(
    "should get admin from repository",
    () async {
      //arrange
      when(repository.doLogin(any)).thenAnswer((_) async => Right(admin));
      //act
      final result =
          await usecase.login({'username': username, 'password': password});

      //assert
      expect(result, Right(admin));
      verify(repository.doLogin({'username': username, 'password': password}));
      verifyNoMoreInteractions(repository);
    },
  );
}
