// Mocks generated by Mockito 5.4.4 from annotations
// in video_game_catalogue_riverpod/test/mock/mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:flutter_riverpod/flutter_riverpod.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:state_notifier/state_notifier.dart' as _i6;
import 'package:video_game_catalogue_riverpod/models/review.dart' as _i8;
import 'package:video_game_catalogue_riverpod/models/user.dart' as _i2;
import 'package:video_game_catalogue_riverpod/providers/review_provider.dart'
    as _i7;
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart'
    as _i4;

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

class _FakeAutoDisposeAsyncNotifierProviderRef_1<T> extends _i1.SmartFake
    implements _i3.AutoDisposeAsyncNotifierProviderRef<T> {
  _FakeAutoDisposeAsyncNotifierProviderRef_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAsyncValue_2<T> extends _i1.SmartFake implements _i3.AsyncValue<T> {
  _FakeAsyncValue_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [UserSessionNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserSessionNotifier extends _i1.Mock
    implements _i4.UserSessionNotifier {
  MockUserSessionNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set onError(_i3.ErrorListener? _onError) => super.noSuchMethod(
        Invocation.setter(
          #onError,
          _onError,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get mounted => (super.noSuchMethod(
        Invocation.getter(#mounted),
        returnValue: false,
      ) as bool);

  @override
  _i5.Stream<_i2.User> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i5.Stream<_i2.User>.empty(),
      ) as _i5.Stream<_i2.User>);

  @override
  _i2.User get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeUser_0(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.User);

  @override
  set state(_i2.User? value) => super.noSuchMethod(
        Invocation.setter(
          #state,
          value,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.User get debugState => (super.noSuchMethod(
        Invocation.getter(#debugState),
        returnValue: _FakeUser_0(
          this,
          Invocation.getter(#debugState),
        ),
      ) as _i2.User);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  void setUser(_i2.User? user) => super.noSuchMethod(
        Invocation.method(
          #setUser,
          [user],
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool updateShouldNotify(
    _i2.User? old,
    _i2.User? current,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateShouldNotify,
          [
            old,
            current,
          ],
        ),
        returnValue: false,
      ) as bool);

  @override
  _i3.RemoveListener addListener(
    _i6.Listener<_i2.User>? listener, {
    bool? fireImmediately = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
          {#fireImmediately: fireImmediately},
        ),
        returnValue: () {},
      ) as _i3.RemoveListener);

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [ReviewNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockReviewNotifier extends _i1.Mock implements _i7.ReviewNotifier {
  MockReviewNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.AutoDisposeAsyncNotifierProviderRef<List<_i8.Review>> get ref =>
      (super.noSuchMethod(
        Invocation.getter(#ref),
        returnValue:
            _FakeAutoDisposeAsyncNotifierProviderRef_1<List<_i8.Review>>(
          this,
          Invocation.getter(#ref),
        ),
      ) as _i3.AutoDisposeAsyncNotifierProviderRef<List<_i8.Review>>);

  @override
  _i3.AsyncValue<List<_i8.Review>> get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeAsyncValue_2<List<_i8.Review>>(
          this,
          Invocation.getter(#state),
        ),
      ) as _i3.AsyncValue<List<_i8.Review>>);

  @override
  set state(_i3.AsyncValue<List<_i8.Review>>? newState) => super.noSuchMethod(
        Invocation.setter(
          #state,
          newState,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i5.Future<List<_i8.Review>> get future => (super.noSuchMethod(
        Invocation.getter(#future),
        returnValue: _i5.Future<List<_i8.Review>>.value(<_i8.Review>[]),
      ) as _i5.Future<List<_i8.Review>>);

  @override
  _i5.Future<List<_i8.Review>> build() => (super.noSuchMethod(
        Invocation.method(
          #build,
          [],
        ),
        returnValue: _i5.Future<List<_i8.Review>>.value(<_i8.Review>[]),
      ) as _i5.Future<List<_i8.Review>>);

  @override
  _i5.Future<void> refresh() => (super.noSuchMethod(
        Invocation.method(
          #refresh,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> addGameRating(_i8.Review? review) => (super.noSuchMethod(
        Invocation.method(
          #addGameRating,
          [review],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> updateGameRating(_i8.Review? review) => (super.noSuchMethod(
        Invocation.method(
          #updateGameRating,
          [review],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> addGameComment(_i8.Review? review) => (super.noSuchMethod(
        Invocation.method(
          #addGameComment,
          [review],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> updateGameComment(
    _i8.Review? review,
    String? newComment,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateGameComment,
          [
            review,
            newComment,
          ],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> deleteGameComment(_i8.Review? review) => (super.noSuchMethod(
        Invocation.method(
          #deleteGameComment,
          [review],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<List<_i8.Review>> update(
    _i5.FutureOr<List<_i8.Review>> Function(List<_i8.Review>)? cb, {
    _i5.FutureOr<List<_i8.Review>> Function(
      Object,
      StackTrace,
    )? onError,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #update,
          [cb],
          {#onError: onError},
        ),
        returnValue: _i5.Future<List<_i8.Review>>.value(<_i8.Review>[]),
      ) as _i5.Future<List<_i8.Review>>);

  @override
  bool updateShouldNotify(
    _i3.AsyncValue<List<_i8.Review>>? previous,
    _i3.AsyncValue<List<_i8.Review>>? next,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateShouldNotify,
          [
            previous,
            next,
          ],
        ),
        returnValue: false,
      ) as bool);
}