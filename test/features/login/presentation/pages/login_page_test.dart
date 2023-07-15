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
import 'package:dcvc_flutter/features/home_page/presentation/pages/home_page.dart';
import 'package:dcvc_flutter/features/login/presentation/bloc/login_bloc.dart';
import 'package:dcvc_flutter/features/login/presentation/pages/login_page.dart';
import 'package:dcvc_flutter/features/login/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FakeLoginEvent extends Fake implements LoginEvent {}

class FakeLoginState extends Fake implements LoginState {}

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

class FakeAuthEvent extends Fake implements AuthEvent {}

class FakeAuthState extends Fake implements AuthState {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  group('LoginPage', () {
    late LoginBloc loginBloc;
    late AuthBloc authBloc;

    setUpAll(() {
      registerFallbackValue(FakeLoginEvent());
      registerFallbackValue(FakeLoginState());
      registerFallbackValue(FakeAuthEvent());
      registerFallbackValue(FakeAuthState());
    });

    setUp(() {
      loginBloc = MockLoginBloc();
      authBloc = MockAuthBloc();
    });

    testWidgets('Tests that back button leads to the home Page',
        (WidgetTester tester) async {
      when(() => loginBloc.state).thenReturn(const LoginState());
      when(() => authBloc.state).thenReturn(NotLoggedIn());
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => loginBloc),
            BlocProvider(create: (_) => authBloc),
          ],
          child: const MaterialApp(
            home: LoginPage(),
          ),
        ),
      );
      Future<void> _navigateToHomePage(WidgetTester tester) async {
        await tester.tap(find.byKey(const Key("Back Button")));
        await tester.pumpAndSettle();
      }

      await _navigateToHomePage(tester);
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('renders the login form', (tester) async {
      when(() => loginBloc.state).thenReturn(const LoginState());
      when(() => authBloc.state).thenReturn(NotLoggedIn());
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => loginBloc),
            BlocProvider(create: (_) => authBloc),
          ],
          child: const MaterialApp(
            home: LoginPage(),
          ),
        ),
      );
      expect(find.byType(LoginForm), findsOneWidget);
    });
  });
}
