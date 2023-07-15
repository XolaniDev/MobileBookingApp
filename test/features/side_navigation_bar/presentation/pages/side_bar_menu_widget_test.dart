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
import 'package:dcvc_flutter/features/logout/presentation/widget/logout_modal.dart';
import 'package:dcvc_flutter/features/login/presentation/bloc/login_bloc.dart';
import 'package:dcvc_flutter/features/side_navigation_bar/presentation/pages/side_bar_menu.dart';
import 'package:dcvc_flutter/features/side_navigation_bar/presentation/widgets/drawer_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FakeAuthState extends Fake implements AuthState {}

class FakeAuthEvent extends Fake implements AuthEvent {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class FakeLoginEvent extends Fake implements LoginEvent {}

class MockNavigationObserver extends Mock implements NavigatorObserver {}

class FakeLoginState extends Fake implements LoginState {}

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  late AuthBloc authBloc;
  late LoginBloc loginBloc;

  setUpAll(() {
    registerFallbackValue(FakeAuthState());
    registerFallbackValue(FakeAuthEvent());
    registerFallbackValue(FakeLoginEvent());
    registerFallbackValue(FakeLoginState());
  });

  setUp(() {
    authBloc = MockAuthBloc();
    loginBloc = MockLoginBloc();
  });

  testWidgets(
    "Test that navigation drawer items are rendered when drawer opens successfully and state is not Logged in.",
    (WidgetTester tester) async {
      //Arrange
      when(() => authBloc.state).thenReturn(NotLoggedIn());

      //Act
      await tester.pumpWidget(
        BlocProvider.value(
          value: authBloc,
          child: const MaterialApp(
            home: Scaffold(
              drawer: NavDrawer(pageindex: 0),
            ),
          ),
        ),
      );

      final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

      expect(find.text('Home'), findsNothing);
      expect(find.text('Profile'), findsNothing);
      expect(find.text('Vaccine Card'), findsNothing);
      expect(find.text('Vaccine Schedule'), findsNothing);
      expect(find.text('Medical History'), findsNothing);
      expect(find.text('Notifications'), findsNothing);
      expect(find.text('Contact Us'), findsNothing);
      expect(find.text('Settings'), findsNothing);
      expect(find.text('Login'), findsNothing);

      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      //Assert
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Vaccine Card'), findsOneWidget);
      expect(find.text('Vaccine Schedule'), findsOneWidget);
      expect(find.text('Medical History'), findsOneWidget);
      expect(find.text('Contact Us'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    },
  );

  testWidgets(
      //Arrange
      "Test that navigation drawer items are rendered when drawer opens successfully and state is Logged in.",
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(LoggedIn('John Smith'));

    //Act
    await tester.pumpWidget(
      BlocProvider.value(
        value: authBloc,
        child: const MaterialApp(
          home: Scaffold(
            drawer: NavDrawer(pageindex: 0),
          ),
        ),
      ),
    );

    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

    expect(find.text('Home'), findsNothing);
    expect(find.text('Profile'), findsNothing);
    expect(find.text('Vaccine Card'), findsNothing);
    expect(find.text('Vaccine Schedule'), findsNothing);
    expect(find.text('Medical History'), findsNothing);
    expect(find.text('Notifications'), findsNothing);
    expect(find.text('Contact Us'), findsNothing);
    expect(find.text('Settings'), findsNothing);
    expect(find.text('Logout'), findsNothing);

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    //Assert
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Vaccine Card'), findsOneWidget);
    expect(find.text('Vaccine Schedule'), findsOneWidget);
    expect(find.text('Medical History'), findsOneWidget);
    expect(find.text('Contact Us'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets(
      //Arrange
      "Tests that tile items are unavailable or available when the state is not logged in .",
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(NotLoggedIn());
    await tester.pumpWidget(
      BlocProvider.value(
        value: authBloc,
        child: const MaterialApp(
          home: Scaffold(
            drawer: NavDrawer(pageindex: 0),
          ),
        ),
      ),
    );

    //Act
    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    //Assert
    expect(
        tester.widget<DrawerListTile>(find.byKey(const Key('Profile'))).enabled,
        false);

    expect(tester.widget<DrawerListTile>(find.byKey(const Key('Home'))).enabled,
        true);

    expect(
        tester
            .widget<DrawerListTile>(find.byKey(const Key('Vaccine Card')))
            .enabled,
        false);

    expect(
        tester
            .widget<DrawerListTile>(find.byKey(const Key('Vaccine Schedule')))
            .enabled,
        false);

    expect(
        tester
            .widget<DrawerListTile>(find.byKey(const Key('Medical History')))
            .enabled,
        false);

    expect(
        tester
            .widget<DrawerListTile>(find.byKey(const Key('Notifications')))
            .enabled,
        false);

    expect(
        tester
            .widget<DrawerListTile>(find.byKey(const Key('Contact Us')))
            .enabled,
        true);

    expect(
        tester
            .widget<DrawerListTile>(find.byKey(const Key('Settings')))
            .enabled,
        true);
  });

  testWidgets(
      //Arrange
      "Tests that tile items are unavailable or available when the state is logged in .",
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(LoggedIn('John Smith'));
    await tester.pumpWidget(
      BlocProvider.value(
        value: authBloc,
        child: const MaterialApp(
          home: Scaffold(
            drawer: NavDrawer(pageindex: 0),
          ),
        ),
      ),
    );

    //Act
    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    //Assert
    expect(
        tester.widget<DrawerListTile>(find.byKey(const Key('Profile'))).enabled,
        true);

    expect(tester.widget<DrawerListTile>(find.byKey(const Key('Home'))).enabled,
        true);

    expect(
        tester
            .widget<DrawerListTile>(find.byKey(const Key('Vaccine Card')))
            .enabled,
        true);

    expect(
        tester
            .widget<DrawerListTile>(find.byKey(const Key('Vaccine Schedule')))
            .enabled,
        true);

    expect(
        tester
            .widget<DrawerListTile>(find.byKey(const Key('Medical History')))
            .enabled,
        true);

    expect(
        tester
            .widget<DrawerListTile>(find.byKey(const Key('Notifications')))
            .enabled,
        true);

    expect(
        tester
            .widget<DrawerListTile>(find.byKey(const Key('Contact Us')))
            .enabled,
        true);

    expect(
        tester
            .widget<DrawerListTile>(find.byKey(const Key('Settings')))
            .enabled,
        true);
  });

  testWidgets(
      //Arrange
      "Tests that will check that a drawer list item navigates to a home page when it is tapped.",
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(NotLoggedIn());
    await tester.pumpWidget(
      BlocProvider.value(
        value: authBloc,
        child: const MaterialApp(
          home: Scaffold(
            drawer: NavDrawer(pageindex: 0),
          ),
        ),
      ),
    );

    //Act
    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    Future<void> _navigateToHomePage(WidgetTester tester) async {
      await tester.tap(find.byKey(const Key('Home')));
      await tester.pumpAndSettle();
    }

    await _navigateToHomePage(tester);

    await tester.pumpAndSettle();

    //Assert
    expect(find.text("Welcome"), findsOneWidget);
  });

  testWidgets(
      //Arrange
      "Tests that will check that a drawer list item navigates to profile page when it is tapped.",
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(LoggedIn('John Smith'));
    await tester.pumpWidget(
      BlocProvider.value(
        value: authBloc,
        child: const MaterialApp(
          home: Scaffold(
            drawer: NavDrawer(pageindex: 1),
          ),
        ),
      ),
    );

    //Act
    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    Future<void> _navigateToProfilePage(WidgetTester tester) async {
      await tester.tap(find.byKey(const Key('Profile')));
      await tester.pumpAndSettle();
    }

    await _navigateToProfilePage(tester);

    await tester.pumpAndSettle();

    //Assert
    expect(find.text("Profile Page"), findsOneWidget);
  });

  testWidgets(
      //Arrange
      "Tests that will check that a drawer list item navigates to conact us page when it is tapped.",
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(NotLoggedIn());
    await tester.pumpWidget(
      BlocProvider.value(
        value: authBloc,
        child: const MaterialApp(
          home: Scaffold(
            drawer: NavDrawer(pageindex: 6),
          ),
        ),
      ),
    );

    //Act
    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    Future<void> _navigateToContactUsPage(WidgetTester tester) async {
      await tester.tap(find.byKey(const Key('Contact Us')));
      await tester.pumpAndSettle();
    }

    await _navigateToContactUsPage(tester);

    await tester.pumpAndSettle();

    //Arrange
    expect(find.text("Contact Us"), findsWidgets);
  });

  testWidgets(
      //Arrange
      "Tests that will check that a drawer list item navigates to settings page when it is tapped.",
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(NotLoggedIn());
    await tester.pumpWidget(
      BlocProvider.value(
        value: authBloc,
        child: const MaterialApp(
          home: Scaffold(
            drawer: NavDrawer(pageindex: 7),
          ),
        ),
      ),
    );

    //Act
    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    Future<void> _navigateToSettinsPage(WidgetTester tester) async {
      await tester.tap(find.byKey(const Key('Settings')));
      await tester.pumpAndSettle();
    }

    await _navigateToSettinsPage(tester);

    await tester.pumpAndSettle();

    expect(find.text("Settings"), findsWidgets);
  });

  testWidgets(
      //Arrange
      "Tests that will check that a drawer list item navigates to Notifications page when it is tapped.",
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(LoggedIn('John Smith'));
    await tester.pumpWidget(
      BlocProvider.value(
        value: authBloc,
        child: const MaterialApp(
          home: Scaffold(
            drawer: NavDrawer(pageindex: 5),
          ),
        ),
      ),
    );

    //Act
    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    Future<void> _navigateToContactUsPage(WidgetTester tester) async {
      await tester.tap(find.byKey(const Key('Notifications')));
      await tester.pumpAndSettle();
    }

    await _navigateToContactUsPage(tester);

    await tester.pumpAndSettle();

    //Assert
    expect(find.text("Notifications"), findsWidgets);
  });

  testWidgets(
      //Arrange
      "Tests that will check that a drawer list item navigates to Medical History page when it is tapped.",
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(LoggedIn('John Smith'));
    await tester.pumpWidget(
      BlocProvider.value(
        value: authBloc,
        child: const MaterialApp(
          home: Scaffold(
            drawer: NavDrawer(pageindex: 4),
          ),
        ),
      ),
    );

    //Act
    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    Future<void> _navigateToMedicalHistoryPage(WidgetTester tester) async {
      await tester.tap(find.byKey(const Key('Medical History')));
      await tester.pumpAndSettle();
    }

    await _navigateToMedicalHistoryPage(tester);

    await tester.pumpAndSettle();

    //Assert
    expect(find.text("Medical History"), findsWidgets);
  });

  testWidgets(
      //Arrange
      "Tests that will check that a drawer list item navigates to Vaccine Schedule page when it is tapped.",
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(LoggedIn('John Smith'));
    await tester.pumpWidget(
      BlocProvider.value(
        value: authBloc,
        child: const MaterialApp(
          home: Scaffold(
            drawer: NavDrawer(pageindex: 3),
          ),
        ),
      ),
    );

    //Act
    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    Future<void> _navigateToVaccineSchedulePage(WidgetTester tester) async {
      await tester.tap(find.byKey(const Key('Vaccine Schedule')));
      await tester.pumpAndSettle();
    }

    await _navigateToVaccineSchedulePage(tester);

    await tester.pumpAndSettle();

    //Assert
    expect(find.text("Vaccine Schedule"), findsWidgets);
  });

  testWidgets(
      //Arrange
      "Tests that will check that a drawer list item navigates to Vaccine Card page when it is tapped.",
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(LoggedIn('John Smith'));
    await tester.pumpWidget(
      BlocProvider.value(
        value: authBloc,
        child: const MaterialApp(
          home: Scaffold(
            drawer: NavDrawer(pageindex: 2),
          ),
        ),
      ),
    );

    //Act
    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    Future<void> _navigateToVaccineCardPage(WidgetTester tester) async {
      await tester.tap(find.byKey(const Key('Vaccine Card')));
      await tester.pumpAndSettle();
    }

    await _navigateToVaccineCardPage(tester);

    await tester.pumpAndSettle();

    //Assert
    expect(find.text("Vaccine Card"), findsWidgets);
  });

  testWidgets(
    "Tests that will check that a drawer list item navigates to login page when it is tapped.",
    (WidgetTester tester) async {
      //Arrange
      when(() => authBloc.state).thenReturn(NotLoggedIn());
      when(() => loginBloc.state).thenReturn(const LoginState());
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => loginBloc),
            BlocProvider(create: (_) => authBloc),
          ],
          child: const MaterialApp(
            home: Scaffold(
              drawer: NavDrawer(pageindex: 8),
            ),
          ),
        ),
      );

      //Act
      final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      Future<void> _navigateToLoginPage(WidgetTester tester) async {
        await tester.tap(find.text("Login"));
        await tester.pumpAndSettle();
      }

      await _navigateToLoginPage(tester);

      await tester.pumpAndSettle();

      //Assert
      expect(find.text("Login"), findsWidgets);
    },
  );

  testWidgets(
      "Tests that the drawer list item navigates to logout widget when it is tapped.",
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(LoggedIn("John Smith"));
    await tester.pumpWidget(
      BlocProvider.value(
        value: authBloc,
        child: const MaterialApp(
          home: Scaffold(
            drawer: NavDrawer(pageindex: 8),
          ),
        ),
      ),
    );

    //Act
    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    Future<void> _navigateToLogoutPopUp(WidgetTester tester) async {
      await tester.tap(find.text("Logout"));
      await tester.pumpAndSettle();
    }

    await _navigateToLogoutPopUp(tester);

    //Assert
  });

  testWidgets(
      //Arrange
      "Tests that the drawer closes when the menu icon is tapped.",
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(NotLoggedIn());
    await tester.pumpWidget(
      BlocProvider.value(
        value: authBloc,
        child: const MaterialApp(
          home: Scaffold(
            drawer: NavDrawer(pageindex: 0),
          ),
        ),
      ),
    );

    //Act
    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    Future<void> _closeDrawer(WidgetTester tester) async {
      await tester.tap(find.byKey(const Key('hamburgerButton')));
      await tester.pumpAndSettle();
    }

    await _closeDrawer(tester);

    //Assert
    expect(find.byKey(const Key('Settings')), findsNothing);
  });
}
