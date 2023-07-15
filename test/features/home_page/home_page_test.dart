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

import 'package:dcvc_flutter/core/bloc/authentication/auth_bloc.dart';
import 'package:dcvc_flutter/features/home_page/presentation/pages/home_page.dart';
import 'package:dcvc_flutter/features/home_page/presentation/widgets/carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class AuthStateFake extends Fake implements AuthState {}

class AuthEventFake extends Fake implements AuthEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(AuthStateFake());
    registerFallbackValue(AuthEventFake());
  });

  testWidgets('Homepage is rendered correctly when user is logged in',
      (WidgetTester tester) async {
    final mock = MockAuthBloc();
    when(() => mock.state).thenReturn(LoggedIn("Mr Name"));

    HomePage widget = const HomePage();

    await tester.pumpWidget(BlocProvider<AuthBloc>(
        create: (context) => mock,
        child: MaterialApp(
          home: Material(child: widget),
        )));

    await tester.pumpAndSettle();

    final circleNotificationsIconFinder =
        find.byIcon(Icons.circle_notifications);
    final welcomeTextFinder = find.text('Welcome');
    final vaccineInfoGuideTextFinder = find.text(
        '\n Discover more information \n on various immunizations \n and vaccine types');
    final imageFinder = find.byType(Image);

    final carouselWidgetFinder = find.byType(Carousel);
    final bookNowButtonFinder = find.byType(ElevatedButton);

    expect(welcomeTextFinder, findsOneWidget);
    expect(vaccineInfoGuideTextFinder, findsOneWidget);
    expect(imageFinder, findsNWidgets(2));
    expect(carouselWidgetFinder, findsOneWidget);
    expect(bookNowButtonFinder, findsOneWidget);
    expect(circleNotificationsIconFinder, findsOneWidget);
  });

  testWidgets('Homepage is rendered correctly when user is not logged in',
      (WidgetTester tester) async {
    final mock = MockAuthBloc();
    when(() => mock.state).thenReturn(NotLoggedIn());

    HomePage widget = const HomePage();

    await tester.pumpWidget(
      BlocProvider<AuthBloc>(
        create: (context) => mock,
        child: MaterialApp(
          home: Material(child: widget),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final circleNotificationsIconFinder =
        find.byIcon(Icons.circle_notifications);
    final welcomeTextFinder = find.text('Welcome');
    final vaccineInfoGuideTextFinder = find.text(
        '\n Discover more information \n on various immunizations \n and vaccine types');
    final imageFinder = find.byType(Image);
    final carouselWidgetFinder = find.byType(Carousel);
    final bookNowButtonFinder = find.byType(ElevatedButton);

    expect(circleNotificationsIconFinder, findsNothing);
    expect(welcomeTextFinder, findsOneWidget);
    expect(vaccineInfoGuideTextFinder, findsOneWidget);
    expect(imageFinder, findsNWidgets(2));
    expect(carouselWidgetFinder, findsOneWidget);
    expect(bookNowButtonFinder, findsOneWidget);
  });

  testWidgets('Make sure drawer is displayed when its oppened',
      (WidgetTester tester) async {
    final mock = MockAuthBloc();
    when(() => mock.state).thenReturn(NotLoggedIn());

    HomePage widget = const HomePage();

    await tester.pumpWidget(
      BlocProvider<AuthBloc>(
        create: (context) => mock,
        child: MaterialApp(
          home: Material(child: widget),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));
    
    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('Profile'), findsNothing);

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    expect(find.text('Profile'), findsOneWidget);
  });
}
