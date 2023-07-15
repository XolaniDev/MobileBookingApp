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
import 'package:dcvc_flutter/features/login/presentation/bloc/login_bloc.dart';
import 'package:dcvc_flutter/features/login/presentation/pages/login_page.dart';
import 'package:dcvc_flutter/features/register/presentation/bloc/register_bloc.dart';
import 'package:dcvc_flutter/features/register/presentation/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:formz/formz.dart';

import '../../../../mock_helper.dart';


void main() {
  late LoginBloc mockLoginBloc;
  late RegisterBloc mockRegisterBloc;
  group('Register_Form', () {
    setUpAll(() {
      registerFallbackValue(FakeRegisterState());
      registerFallbackValue(FakeRegisterEvent());
      registerFallbackValue(FakeLoginState());
      registerFallbackValue(FakeLoginEvent());
    });

    setUp(() {
      mockLoginBloc = MockLoginBloc();
      mockRegisterBloc = MockRegisterBloc();
    });

    testWidgets('Test that all TextForm fields are rendered.',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: RegisterForm()))));

      var fullName = find.byType(FullNameInput);
      var idNumber = find.byType(IdNumberInput);
      var emailAddress = find.byType(EmailInput);
      var mobileNumber = find.byType(MobileNumberInput);
      var password = find.byType(PasswordInput);
      var confirmPassword = find.byType(ConfirmPasswordInput);
      var fields = find.byType(TextFormField);
      var eyeIcons = find.byType(Icon);

      expect(fullName, findsOneWidget);
      expect(idNumber, findsOneWidget);
      expect(emailAddress, findsOneWidget);
      expect(mobileNumber, findsOneWidget);
      expect(password, findsOneWidget);
      expect(confirmPassword, findsOneWidget);
      expect(fields, findsNWidgets(6));
      expect(eyeIcons, findsNWidgets(2));
    });

    testWidgets(
        'Tests that fullname is successfully changed when a fullname is entered in the textformfield.',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      const fullname = 'Harry Styles';
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: RegisterForm()))));

      await tester.enterText(
          find.byKey(const Key('FullName_TextField')), fullname);

      verify(
        () => mockRegisterBloc.add(const RegisterFullNameChanged(fullname)),
      ).called(1);
    });

    testWidgets(
        'Tests that fullname is unsuccessfully changed when an empty fullname is entered in the textformfield.',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      const fullname = '';
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: RegisterForm()))));

      await tester.enterText(
          find.byKey(const Key('FullName_TextField')), fullname);

      verifyNever(
        () => mockRegisterBloc.add(const RegisterFullNameChanged(fullname)),
      );
    });

    testWidgets(
        'Tests that ID number is successfully changed when an ID number is entered in the textformfield.',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      const id = '9903011234567';
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: RegisterForm()))));

      await tester.enterText(find.byKey(const Key('ID_TextField')), id);

      verify(
        () =>
            mockRegisterBloc.add(const RegisterIdentificationNumberChanged(id)),
      ).called(1);
    });

    testWidgets(
        'Tests that ID number is unsuccessfully changed when an empty ID number is entered in the textformfield.',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      const id = '';
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: RegisterForm()))));

      await tester.enterText(find.byKey(const Key('ID_TextField')), id);

      verifyNever(
        () =>
            mockRegisterBloc.add(const RegisterIdentificationNumberChanged(id)),
      );
    });

    testWidgets(
        'Tests that email is successfully changed when an email is entered in the textformfield.',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      const email = 'maddy@gmail.com';
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: RegisterForm()))));

      await tester.enterText(find.byKey(const Key('Email_TextField')), email);

      verify(
        () => mockRegisterBloc.add(const RegisterEmailChanged(email)),
      ).called(1);
    });

    testWidgets(
        'Tests that email is unsuccessfully changed when an empty email is entered in the textformfield.',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      const email = '';
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: RegisterForm()))));

      await tester.enterText(find.byKey(const Key('Email_TextField')), email);

      verifyNever(
        () => mockRegisterBloc.add(const RegisterEmailChanged(email)),
      );
    });

    testWidgets(
        'Tests that mobile number is successfully changed when a mobile number is entered in the textformfield.',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      const mobileNumber = '0711234567';
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: RegisterForm()))));

      await tester.enterText(
          find.byKey(const Key('MobileNumber_TextField')), mobileNumber);

      verify(
        () => mockRegisterBloc
            .add(const RegisterMobileNumberChanged(mobileNumber)),
      ).called(1);
    });

    testWidgets(
        'Tests that mobile number is unsuccessfully changed when an empty mobile number is entered in the textformfield.',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      const mobileNumber = '';
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: RegisterForm()))));

      await tester.enterText(
          find.byKey(const Key('MobileNumber_TextField')), mobileNumber);

      verifyNever(
        () => mockRegisterBloc
            .add(const RegisterMobileNumberChanged(mobileNumber)),
      );
    });

    testWidgets(
        'Tests that password is successfully changed when a password is entered in the textformfield.',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      const password = 'Password1!';
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: RegisterForm()))));

      await tester.enterText(
          find.byKey(const Key('Password_TextField')), password);

      verify(
        () => mockRegisterBloc.add(const RegisterPasswordChanged(password)),
      ).called(1);
    });

    testWidgets(
        'Tests that password is unsuccessfully changed when an empty password is entered in the textformfield.',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      const password = '';
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: RegisterForm()))));

      await tester.enterText(
          find.byKey(const Key('Password_TextField')), password);

      verifyNever(
        () => mockRegisterBloc.add(const RegisterPasswordChanged(password)),
      );
    });

    testWidgets(
        'Tests that confirmPassword is successfully changed when a password is entered in the textformfield.',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      const confirmPassword = 'Password1!';
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: RegisterForm()))));

      await tester.enterText(
          find.byKey(const Key('ConfirmPassword_TextField')), confirmPassword);

      verify(
        () => mockRegisterBloc
            .add(const RegisterConfirmPasswordChanged(confirmPassword)),
      ).called(1);
    });

    testWidgets(
        'Tests that confirmPassword is unsuccessfully changed when an empty password is entered in the textformfield.',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      const confirmPassword = '';
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: RegisterForm()))));

      await tester.enterText(
          find.byKey(const Key('ConfirmPassword_TextField')), confirmPassword);

      verifyNever(
        () => mockRegisterBloc
            .add(const RegisterConfirmPasswordChanged(confirmPassword)),
      );
    });

    testWidgets('Tests that visual icon makes the password visible.',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: RegisterForm()))));

      await tester.tap(find.byKey(const Key("Icon1")));
      await tester.pumpAndSettle();

      verify(
        () => mockRegisterBloc.add(RegisterPasswordVisibilityChanged()),
      ).called(1);
    });

    testWidgets('Tests that visual icon makes the confirm password visible.',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: RegisterForm()))));

      await tester.tap(find.byKey(const Key("Icon2")));
      await tester.pumpAndSettle();

      verify(
        () => mockRegisterBloc.add(RegisterConfirmPasswordVisibilityChanged()),
      ).called(1);
    });

    testWidgets('shows SnackBar when status is submission failure',
        (tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      whenListen(
        mockRegisterBloc,
        Stream.fromIterable([
          const RegisterState(status: FormzStatus.submissionInProgress),
          const RegisterState(status: FormzStatus.submissionFailure),
        ]),
      );
      when(() => mockRegisterBloc.state).thenReturn(
        const RegisterState(status: FormzStatus.submissionFailure),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<RegisterBloc>.value(
              value: mockRegisterBloc,
              child: const RegisterForm(),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets(
      'shows SnackBar when status is submission success.',
      (tester) async {
        // arrange
        whenListen(
          mockRegisterBloc,
          Stream.fromIterable([
            const RegisterState(status: FormzStatus.submissionInProgress),
            const RegisterState(status: FormzStatus.submissionSuccess),
          ]),
        );
        when(() => mockRegisterBloc.state).thenReturn(
          const RegisterState(status: FormzStatus.submissionSuccess),
        );
        when(() => mockRegisterBloc.state).thenReturn(
          const RegisterState(status: FormzStatus.submissionSuccess),
        );
        when(() => mockLoginBloc.state).thenReturn(const LoginState());

        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => mockLoginBloc),
              BlocProvider(create: (_) => mockRegisterBloc),
            ],
            child: const MaterialApp(
              home: Scaffold(
                body: RegisterForm(),
              ),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 1));
        expect(find.byType(SnackBar), findsOneWidget);

        await tester.pumpAndSettle(const Duration(seconds: 3));
        expect(find.byType(LoginPage), findsOneWidget);
      },
    );

    testWidgets('shows no SnackBar when status is submission inprogress.',
        (tester) async {
      // arrange
      whenListen(
        mockRegisterBloc,
        Stream.fromIterable([
          const RegisterState(status: FormzStatus.submissionInProgress),
        ]),
      );
      when(() => mockRegisterBloc.state).thenReturn(
        const RegisterState(status: FormzStatus.submissionInProgress),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<RegisterBloc>.value(
              value: mockRegisterBloc,
              child: const RegisterForm(),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(SnackBar), findsNothing);
    });
  });
}
