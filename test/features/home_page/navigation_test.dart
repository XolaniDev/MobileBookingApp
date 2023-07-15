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
import 'package:dcvc_flutter/features/notifications/pages/notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/src/material/flutter_logo.dart';
import 'package:bloc_test/bloc_test.dart';

class MockNavigationObserver extends Mock implements NavigatorObserver {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class AuthStateFake extends Fake implements AuthState {}

class AuthEventFake extends Fake implements AuthEvent {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('HomePage navigation tests', () {
    late NavigatorObserver mockObserver;

    setUpAll(() {
      mockObserver = MockNavigationObserver();
      registerFallbackValue(AuthStateFake());
      registerFallbackValue(AuthEventFake());
    });

    Future<void> _buildHomePage(WidgetTester tester) async {
      final mock = MockAuthBloc();
      when(() => mock.state).thenReturn(LoggedIn("Mr Name"));

      await tester.pumpWidget(
        BlocProvider<AuthBloc>(
          create: (context) => mock,
          child: MaterialApp(
            home: const HomePage(),
            navigatorObservers: [mockObserver],
          ),
        ),
      );

      await tester.pumpAndSettle();
    }

    Future<void> _navigateToVaccineInfoGuidePage(WidgetTester tester) async {
      await tester.tap(find.byKey(HomePage.navigateToVaccineInfoGuid));
      await tester.pumpAndSettle();
    }

    Future<void> _navigateToBookNowPage(WidgetTester tester) async {
      await tester.tap(find.byKey(HomePage.navigateToBookNow));
      await tester.pumpAndSettle();
    }

    Future<void> _navigateToNotificationsPage(WidgetTester tester) async {
      await tester.tap(find.byKey(HomePage.navigateToNotifications));
      await tester.pumpAndSettle();
    }

    testWidgets(
        'When tapping "VaccineInfoGuide" Sized box should navigate to VaccineInfoGuide page',
        (WidgetTester tester) async {
      await _buildHomePage(tester);
      await _navigateToVaccineInfoGuidePage(tester);

      expect(find.byType(FlutterLogo), findsOneWidget);
    });

    testWidgets(
        'When tapping "Book Now" button should navigate to BookNow page',
        (WidgetTester tester) async {
      await _buildHomePage(tester);
      await _navigateToBookNowPage(tester);

      expect(find.byType(FlutterLogo), findsOneWidget);
    });

    testWidgets(
        'When tapping "Notifications" icon should navigate to Notifications page',
        (WidgetTester tester) async {
      await _buildHomePage(tester);
      await _navigateToNotificationsPage(tester);

      expect(find.byType(NotificationsPage), findsOneWidget);
    });
  });
}
