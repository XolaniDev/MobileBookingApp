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
import 'package:dcvc_flutter/features/login/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
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
  group('LoginForm', () {
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

    testWidgets('Test that all TextForm fields are rendered.',
        (WidgetTester tester) async {
      final mockLoginBloc = MockLoginBloc();
      when(() => mockLoginBloc.state).thenReturn(const LoginState());

      await tester.pumpWidget(BlocProvider<LoginBloc>(
          create: (context) => mockLoginBloc,
          child: const MaterialApp(home: Material(child: LoginForm()))));

      final idNumber = find.byType(IdNumberInput);
      final password = find.byType(PasswordInput);
      var fields = find.byType(TextFormField);
      var eyeIcons = find.byType(Icon);

      expect(idNumber, findsOneWidget);
      expect(password, findsOneWidget);
      expect(fields, findsNWidgets(2));
      expect(eyeIcons, findsNWidgets(1));
    });

    testWidgets(
        'Tests that ID number is successfully changed when an ID number is entered in the textformfield.',
        (WidgetTester tester) async {
      final mockLoginBloc = MockLoginBloc();
      const id = '9903011234567';
      when(() => mockLoginBloc.state).thenReturn(const LoginState());

      await tester.pumpWidget(BlocProvider<LoginBloc>(
          create: (context) => mockLoginBloc,
          child: const MaterialApp(home: Material(child: LoginForm()))));

      await tester.enterText(find.byKey(const Key('ID_TextField')), id);

      verify(
        () => mockLoginBloc.add(const LoginIdentificationNumberChanged(id)),
      ).called(1);
    });

    testWidgets(
        'Tests that ID number is unsuccessfully changed when an empty ID number is entered in the textformfield.',
        (WidgetTester tester) async {
      final mockLoginBloc = MockLoginBloc();
      const id = '';
      when(() => mockLoginBloc.state).thenReturn(const LoginState());

      await tester.pumpWidget(BlocProvider<LoginBloc>(
          create: (context) => mockLoginBloc,
          child: const MaterialApp(home: Material(child: LoginForm()))));

      await tester.enterText(find.byKey(const Key('ID_TextField')), id);

      verifyNever(
        () => mockLoginBloc.add(const LoginIdentificationNumberChanged(id)),
      );
    });

    testWidgets(
        'Tests that password is successfully changed when a password is entered in the textformfield.',
        (WidgetTester tester) async {
      final mockLoginBloc = MockLoginBloc();
      const password = 'Password1!';
      when(() => mockLoginBloc.state).thenReturn(const LoginState());

      await tester.pumpWidget(BlocProvider<LoginBloc>(
          create: (context) => mockLoginBloc,
          child: const MaterialApp(home: Material(child: LoginForm()))));

      await tester.enterText(
          find.byKey(const Key('Password_TextField')), password);

      verify(
        () => mockLoginBloc.add(const LoginPasswordChanged(password)),
      ).called(1);
    });

    testWidgets(
        'Tests that password is unsuccessfully changed when an empty password is entered in the textformfield.',
        (WidgetTester tester) async {
      final mockLoginBloc = MockLoginBloc();
      const password = '';
      when(() => mockLoginBloc.state).thenReturn(const LoginState());

      await tester.pumpWidget(BlocProvider<LoginBloc>(
          create: (context) => mockLoginBloc,
          child: const MaterialApp(home: Material(child: LoginForm()))));

      await tester.enterText(
          find.byKey(const Key('Password_TextField')), password);

      verifyNever(
        () => mockLoginBloc.add(const LoginPasswordChanged(password)),
      );
    });

    testWidgets(
      'shows SnackBar when status is submission success.',
      (tester) async {
        // arrange
        whenListen(
          loginBloc,
          Stream.fromIterable([
            const LoginState(status: FormzStatus.submissionInProgress),
            const LoginState(status: FormzStatus.submissionSuccess),
          ]),
        );
        when(() => loginBloc.state).thenReturn(
          const LoginState(status: FormzStatus.submissionSuccess),
        );
        when(() => authBloc.state).thenReturn(LoggedIn('John'));
        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => loginBloc),
              BlocProvider(create: (_) => authBloc),
            ],
            child: const MaterialApp(
              home: Scaffold(
                body: LoginForm(),
              ),
            ),
          ),
        );

        await tester.pump(const Duration(milliseconds: 1));
        expect(find.byType(SnackBar), findsOneWidget);

        await tester.pump(const Duration(minutes: 1));
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);
      },
    );

    testWidgets('shows SnackBar when status is submission failure',
        (tester) async {
      whenListen(
        loginBloc,
        Stream.fromIterable([
          const LoginState(status: FormzStatus.submissionInProgress),
          const LoginState(status: FormzStatus.submissionFailure),
        ]),
      );
      when(() => loginBloc.state).thenReturn(
        const LoginState(status: FormzStatus.submissionFailure),
      );
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => loginBloc),
            BlocProvider(create: (_) => authBloc),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: LoginForm(),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
