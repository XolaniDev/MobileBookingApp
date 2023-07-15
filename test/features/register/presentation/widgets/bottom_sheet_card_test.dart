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
import 'package:dcvc_flutter/features/register/presentation/bloc/register_bloc.dart';
import 'package:dcvc_flutter/features/register/presentation/widgets/bottom_sheet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:formz/formz.dart';

class MockRegisterBloc extends MockBloc<RegisterEvent, RegisterState>
    implements RegisterBloc {}

class RegisterStateFake extends Fake implements RegisterState {}

class RegisterEventFake extends Fake implements RegisterEvent {}

void main() {
  group('Bottom_Sheet_Card', () {
    setUpAll(() {
      registerFallbackValue(RegisterStateFake());
      registerFallbackValue(RegisterEventFake());
    });

    testWidgets('Test that bottom sheet card items are rendered successfully',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: BottomSheetCard()))));

      final textFinder = find.text('Register');
      final button = find.byType(ElevatedButton);
      var link = find.byType(RichText);
      var checkbox = find.byType(Checkbox);

      expect(textFinder, findsOneWidget);
      expect(button, findsOneWidget);
      expect(link, findsNWidgets(3));
      expect(checkbox, findsOneWidget);
    });

    testWidgets('Test that T&Cs page is rendered when T&Cs link is tapped.',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: BottomSheetCard()))));

      Future<void> _navigateToTandCsPage(WidgetTester tester) async {
        await tester.tap(find.byKey(const Key('T&C_link')));
        await tester.pump();
      }

      await _navigateToTandCsPage(tester);
      await tester.pump();

      expect(find.text("Terms and Conditions"), findsOneWidget);
    });

    testWidgets('Test that checkbox state is changed when checkbox is checked.',
        (WidgetTester tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());

      await tester.pumpWidget(BlocProvider<RegisterBloc>(
          create: (context) => mockRegisterBloc,
          child: const MaterialApp(home: Material(child: BottomSheetCard()))));

      Future<void> _changeCheckboxState(WidgetTester tester) async {
        await tester.tap(find.byType(Checkbox));
        await tester.pumpAndSettle();
      }

      await _changeCheckboxState(tester);
      await tester.pumpAndSettle();

      final checkboxFinder = find.byType(Checkbox);
      var checkbox = tester.firstWidget(checkboxFinder) as Checkbox;

      expect(checkbox.value, true);
    });

    testWidgets('register button is disabled by default', (tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<RegisterBloc>.value(
              value: mockRegisterBloc,
              child: const BottomSheetCard(),
            ),
          ),
        ),
      );
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.enabled, isFalse);
    });

    testWidgets('tests that register button checks submission after tapped.',
        (tester) async {
      final mockRegisterBloc = MockRegisterBloc();
      whenListen(
        mockRegisterBloc,
        Stream.fromIterable([
          const RegisterState(status: FormzStatus.valid),
        ]),
      );
      when(() => mockRegisterBloc.state).thenReturn(
        const RegisterState(status: FormzStatus.valid),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<RegisterBloc>.value(
              value: mockRegisterBloc,
              child: const BottomSheetCard(),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(ElevatedButton));
      verify(
        () => mockRegisterBloc.add(const RegisterSubmitted()),
      ).called(1);
    });
  });
}
