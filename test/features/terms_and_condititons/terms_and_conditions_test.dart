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

import 'package:dcvc_flutter/features/register/presentation/bloc/register_bloc.dart';
import 'package:dcvc_flutter/features/register/presentation/pages/register_page.dart';
import 'package:dcvc_flutter/features/terms_and_conditions/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock_helper.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(FakeRegisterState());
    registerFallbackValue(FakeRegisterEvent());
  });

  /// Tests that the [TermsAndConditionsScreen] loads correctly.
  testWidgets('Terms and Conditions Loads Correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TermsAndConditionsScreen());

    expect(find.text('Terms and Conditions'), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(FutureBuilder), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
  });

  testWidgets('Finds the instance of the Card', (WidgetTester tester) async {
    const childWidget =
        Card(margin: EdgeInsets.symmetric(horizontal: 25, vertical: 9));
    // Provide the childWidget to the Container.
    await tester.pumpWidget(const Material(child: childWidget));
    // Search for the childWidget in the tree and verify it exists.
    expect(find.byWidget(childWidget), findsOneWidget);
  });

  testWidgets('Finds the instance of the Column', (WidgetTester tester) async {
    final childWidget = Column();
    // Provide the childWidget to the Container.
    await tester.pumpWidget(Container(child: childWidget));
    // Search for the childWidget in the tree and verify it exists.
    expect(find.byWidget(childWidget), findsOneWidget);
  });

  testWidgets('Finds the instance of the Row', (WidgetTester tester) async {
    final childWidget = Row(mainAxisAlignment: MainAxisAlignment.spaceBetween);
    // Provide the childWidget to the Container.
    await tester.pumpWidget(Container(child: childWidget));
    // Search for the childWidget in the tree and verify it exists.
    expect(find.byWidget(childWidget), findsOneWidget);
  });

  ///Test that the back button returns the [RegisterPage]
  testWidgets(
    'Back Button is present and triggers navigation after tapped',
    (WidgetTester tester) async {
      final RegisterBloc mockRegisterBloc = MockRegisterBloc();
      final mockObserver = MockNavigationObserver();
      when(() => mockRegisterBloc.state).thenReturn(const RegisterState());
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [BlocProvider(create: (_) => mockRegisterBloc)],
          child: MaterialApp(
            home: const TermsAndConditionsScreen(),
            navigatorObservers: [mockObserver],
          ),
        ),
      );
      expect(find.byType(IconButton), findsOneWidget);
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();
      expect(find.byType(RegisterPage), findsOneWidget);
    },
  );

  testWidgets('Tests that the page is scrollable', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    (WidgetTester tester) async {
      await tester.pumpWidget(const TermsAndConditionsScreen());
      final listFinder = find.byType(Scrollable);
      final itemFinder = find.byType(TermsAndConditionsScreen);
      // Scroll until the item to be found appears.
      await tester.scrollUntilVisible(
        itemFinder,
        500.0,
        scrollable: listFinder,
      );
      // Verify that the item contains the correct text.
      expect(itemFinder, findsOneWidget);
    };
  });
}
