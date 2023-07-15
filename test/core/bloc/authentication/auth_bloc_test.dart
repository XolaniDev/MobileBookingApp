/*
 * [2019] - [2021] Eblocks Software (Pty) Ltd, All Rights Reserved.
 * NOTICE: All information contained herein is, and remains the property of Eblocks
 * Software (Pty) Ltd.
 * and its suppliers (if any). The intellectual and technical concepts contained herein
 * are proprietary
 * to Eblocks Software (Pty) Ltd. and its suppliers (if any) and may be covered by South 
 * African, U.S.
 * and Foreign patents, patents in process, and are protected by trade secret and / or 
 * copyright law.
 * Dissemination of this information or reproduction of this material is forbidden unless
 * prior written
 * permission is obtained from Eblocks Software (Pty) Ltd.
*/

import 'package:bloc_test/bloc_test.dart';
import 'package:dcvc_flutter/core/bloc/authentication/auth_bloc.dart';
import 'package:dcvc_flutter/features/logout/data/log_out.dart';
import 'package:dcvc_flutter/features/side_navigation_bar/domain/get_user_name.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// A [Mock] class for [GetUserName] class.
class MockGetUserName extends Mock implements GetUserName {}

class MockLogout extends Mock implements Logout {}

void main() {
  late AuthBloc authBloc;
  late MockGetUserName mockGetUserName;
  late MockLogout mockLogout;

  setUp(() {
    mockGetUserName = MockGetUserName();
    mockLogout = MockLogout();
    authBloc = AuthBloc(
      getUserName: mockGetUserName,
      logout: mockLogout,
    );
  });

  /// Contains bloc tests for the [AuthBloc] class
  group(
    'AuthBloc',
    () {
      /// Tests that a [LoggedIn] state occurs when the [AuthLogIn] is called.
      blocTest(
        'login',
        build: () {
          when(() => mockGetUserName()).thenAnswer((_) async => "Hello");
          return authBloc;
        },
        act: (AuthBloc bloc) {
          bloc.add(AuthLogIn());
        },
        expect: () => [isA<LoggedIn>()],
      );

      /// Tests that a [NotLoggedIn] state occurs when the [AuthLogOut] is called.
      blocTest(
        'logout',
        build: () {
          when(() => mockGetUserName()).thenAnswer((_) async => "John Smith");
          when(() => mockLogout.removeSavedPref())
              .thenAnswer((_) => Future.value());
          return authBloc;
        },
        act: (AuthBloc bloc) {
          bloc.add(AuthLogIn());
          bloc.add(AuthLogOut());
        },
        expect: () => [
          isA<LoggedIn>(),
          isA<NotLoggedIn>(),
        ],
      );
    },
  );
}
