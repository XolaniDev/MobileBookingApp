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
import 'package:dcvc_flutter/features/login/presentation/bloc/login_bloc.dart';
import 'package:dcvc_flutter/features/login/presentation/pages/login_page.dart';
import 'package:dcvc_flutter/features/register/presentation/bloc/register_bloc.dart';
import 'package:dcvc_flutter/features/register/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mock_helper.dart';


void main() {
  late LoginBloc mockLoginBloc;
  late RegisterBloc mockRegisterBloc;
 
  group('Register_Page', () {
    setUpAll(() {
      registerFallbackValue(FakeRegisterState());
      registerFallbackValue(FakeRegisterEvent());
      registerFallbackValue(FakeLoginEvent());
      registerFallbackValue(FakeLoginState());
    });

    setUp(() {
      mockRegisterBloc = MockRegisterBloc();
      mockLoginBloc = MockLoginBloc();
    });

    testWidgets('Check if page layout is correct', (WidgetTester tester) async {
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
        create: (context) => mockRegisterBloc,
        child: const MaterialApp(
          home: Material(child: RegisterPage()),
        ),
      ));

      var backButton = find.byType(IconButton);
      var pageTitle = find.text("Create an account");
      var sheetCard = find.byType(Card);

      expect(backButton, findsNWidgets(3));
      expect(pageTitle, findsOneWidget);
      expect(sheetCard, findsOneWidget);
    });

    testWidgets(
      'Tests that back button leads to the Login Page',
      (WidgetTester tester) async {
        // arrange
        when(() => mockRegisterBloc.state).thenReturn(const RegisterState());
        when(() => mockLoginBloc.state).thenReturn(const LoginState());

        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider<LoginBloc>(create: (context) => mockLoginBloc),
              BlocProvider<RegisterBloc>(
                create: (context) => mockRegisterBloc,
              )
            ],
            child: const MaterialApp(
              home: Material(child: RegisterPage()),
            ),
          ),
        );

        Future<void> _navigateToLoginPage(WidgetTester tester) async {
          await tester.tap(find.byKey(const Key("BackButton")));
          await tester.pumpAndSettle();
        }

        await _navigateToLoginPage(tester);
        await tester.pumpAndSettle();

        expect(find.byType(LoginPage), findsOneWidget);
      },
    );
  });
}
