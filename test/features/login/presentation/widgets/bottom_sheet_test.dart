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
import 'package:dcvc_flutter/features/login/presentation/widgets/bottom_sheet.dart';
import 'package:dcvc_flutter/features/login/presentation/widgets/login_form.dart';
import 'package:dcvc_flutter/features/register/presentation/bloc/register_bloc.dart';
import 'package:dcvc_flutter/features/register/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mock_helper.dart';

void main() {
  group('LoginForm', () {
    late LoginBloc loginBloc;
    late RegisterBloc registerBloc;
    late NavigatorObserver mockObserver;

    setUpAll(() {
      mockObserver = MockNavigationObserver();
      registerFallbackValue(FakeLoginEvent());
      registerFallbackValue(FakeLoginState());
      registerFallbackValue(FakeRegisterEvent());
      registerFallbackValue(FakeRegisterState());
    });

    setUp(() {
      loginBloc = MockLoginBloc();
      registerBloc = MockRegisterBloc();
    });

    testWidgets('finds login button', (tester) async {
      when(() => loginBloc.state).thenReturn(const LoginState());
      await tester.pumpWidget(
        BlocProvider.value(
          value: loginBloc,
          child: const MaterialApp(
            home: Scaffold(
              bottomSheet: BottomSheetCard(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('finds register link', (tester) async {
      when(() => loginBloc.state).thenReturn(const LoginState());
      when(() => registerBloc.state).thenReturn(const RegisterState());
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => loginBloc),
            BlocProvider(create: (_) => registerBloc),
          ],
          child: const MaterialApp(
            home: Scaffold(
              bottomSheet: BottomSheetCard(),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byKey(const Key('Top')), findsOneWidget);
    });

    testWidgets('register link taps', (tester) async {
      // arrange
      final RegisterBloc mockRegisterBloc = MockRegisterBloc();
      when(() => loginBloc.state).thenReturn(const LoginState());
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => loginBloc),
            BlocProvider(create: (_) => mockRegisterBloc),
          ],
          child: MaterialApp(
            navigatorObservers: [mockObserver],
            home: const Scaffold(
              bottomSheet: BottomSheetCard(),
            ),
          ),
        ),
      );

      Future<void> _navigatesToRegisterPage(WidgetTester tester) async {
        await tester.tap(find.byKey(const Key('Top')));
        await tester.pumpAndSettle();
      }

      await _navigatesToRegisterPage(tester);

      expect(find.byType(RegisterPage), findsOneWidget);
    });

    testWidgets(
      'continue button is enabled when status is validated',
      (tester) async {
        when(() => loginBloc.state).thenReturn(
          const LoginState(status: FormzStatus.valid),
        );
        await tester.pumpWidget(
          BlocProvider.value(
            value: loginBloc,
            child: const MaterialApp(
              home: Scaffold(
                bottomSheet: BottomSheetCard(),
              ),
            ),
          ),
        );
        final button =
            tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        expect(button.enabled, isTrue);
      },
    );

    testWidgets('continue button is disabled by default', (tester) async {
      when(() => loginBloc.state).thenReturn(const LoginState());
      await tester.pumpWidget(
        BlocProvider.value(
          value: loginBloc,
          child: const MaterialApp(
            home: Scaffold(
              bottomSheet: BottomSheetCard(),
            ),
          ),
        ),
      );
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.enabled, isFalse);
    });

    testWidgets('LoginSubmitted is added to LoginBloc when continue is tapped',
        (tester) async {
      when(() => loginBloc.state).thenReturn(
        const LoginState(status: FormzStatus.valid),
      );
      await tester.pumpWidget(
        BlocProvider.value(
          value: loginBloc,
          child: const MaterialApp(
            home: Scaffold(
              bottomSheet: BottomSheetCard(),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(ElevatedButton));
      verify(() => loginBloc.add(const LoginSubmitted())).called(1);
    });

    testWidgets('shows popup when status is submission failure',
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
        BlocProvider.value(
          value: loginBloc,
          child: MaterialApp(
            home: Scaffold(
              body: Container(
                child: Column(
                  children: const [
                    LoginForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
