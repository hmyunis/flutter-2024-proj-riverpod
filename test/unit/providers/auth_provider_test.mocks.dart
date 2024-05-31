// Mocks generated by Mockito 5.4.4 from annotations
// in video_game_catalogue_riverpod/test/unit/providers/auth_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;
import 'package:video_game_catalogue_riverpod/data/repositories/auth_repository.dart'
    as _i3;
import 'package:video_game_catalogue_riverpod/data/repositories/users_repository.dart'
    as _i6;
import 'package:video_game_catalogue_riverpod/models/user.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUser_0 extends _i1.SmartFake implements _i2.User {
  _FakeUser_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i3.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<String> login(
    String? username,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [
            username,
            password,
          ],
        ),
        returnValue: _i4.Future<String>.value(_i5.dummyValue<String>(
          this,
          Invocation.method(
            #login,
            [
              username,
              password,
            ],
          ),
        )),
      ) as _i4.Future<String>);

  @override
  _i4.Future<String> register(
    String? username,
    String? email,
    String? password,
    String? confirmPassword,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #register,
          [
            username,
            email,
            password,
            confirmPassword,
          ],
        ),
        returnValue: _i4.Future<String>.value(_i5.dummyValue<String>(
          this,
          Invocation.method(
            #register,
            [
              username,
              email,
              password,
              confirmPassword,
            ],
          ),
        )),
      ) as _i4.Future<String>);

  @override
  _i4.Future<void> logout() => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [UsersRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUsersRepository extends _i1.Mock implements _i6.UsersRepository {
  MockUsersRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.User> getCurrentUser(String? token) => (super.noSuchMethod(
        Invocation.method(
          #getCurrentUser,
          [token],
        ),
        returnValue: _i4.Future<_i2.User>.value(_FakeUser_0(
          this,
          Invocation.method(
            #getCurrentUser,
            [token],
          ),
        )),
      ) as _i4.Future<_i2.User>);

  @override
  _i4.Future<_i2.User> getUserById(int? userId) => (super.noSuchMethod(
        Invocation.method(
          #getUserById,
          [userId],
        ),
        returnValue: _i4.Future<_i2.User>.value(_FakeUser_0(
          this,
          Invocation.method(
            #getUserById,
            [userId],
          ),
        )),
      ) as _i4.Future<_i2.User>);

































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































  @override
  _i4.Future<List<_i2.User>> getUsers() => (super.noSuchMethod(
        Invocation.method(
          #getUsers,
          [],
        ),
        returnValue: _i4.Future<List<_i2.User>>.value(<_i2.User>[]),
      ) as _i4.Future<List<_i2.User>>);

  @override
  _i4.Future<_i2.User> updateUser(
    _i2.User? user,
    String? newPassword,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateUser,
          [
            user,
            newPassword,
          ],
        ),
        returnValue: _i4.Future<_i2.User>.value(_FakeUser_0(
          this,
          Invocation.method(
            #updateUser,
            [
              user,
              newPassword,
            ],
          ),
        )),
      ) as _i4.Future<_i2.User>);

  @override
  _i4.Future<dynamic> deleteUser(int? userId) => (super.noSuchMethod(
        Invocation.method(
          #deleteUser,
          [userId],
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);

  @override
  _i4.Future<_i2.User> toggleAdmin(
    int? userId,
    String? token,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #toggleAdmin,
          [
            userId,
            token,
          ],
        ),
        returnValue: _i4.Future<_i2.User>.value(_FakeUser_0(
          this,
          Invocation.method(
            #toggleAdmin,
            [
              userId,
              token,
            ],
          ),
        )),
      ) as _i4.Future<_i2.User>);
}