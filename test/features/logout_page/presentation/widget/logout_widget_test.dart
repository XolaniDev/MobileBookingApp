import 'package:bloc_test/bloc_test.dart';
import 'package:dcvc_flutter/core/bloc/authentication/auth_bloc.dart';
import 'package:dcvc_flutter/features/logout/presentation/widget/logout_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dcvc_flutter/features/side_navigation_bar/presentation/pages/side_bar_menu.dart';
import 'package:dcvc_flutter/features/home_page/presentation/pages/home_page.dart';

class FakeAuthState extends Fake implements AuthState {}

class FakeAuthEvent extends Fake implements AuthEvent {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late AuthBloc authBloc;

  setUpAll(() {
    registerFallbackValue(FakeAuthState());
    registerFallbackValue(FakeAuthEvent());
  });

  setUp(() {
    authBloc = MockAuthBloc();
  });

  testWidgets('Test that find shows pop up dialog when logout is clicked. ',
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(LoggedIn('name'));
    await tester.pumpWidget(BlocProvider.value(
      value: authBloc,
      child: const MaterialApp(
        home: Scaffold(
          drawer: NavDrawer(pageindex: 8),
        ),
      ),
    ));

    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    Future<void> _navigateToLogoutPopUp(WidgetTester tester) async {
      await tester.tap(find.text("Logout"));
      await tester.pumpAndSettle();
    }

    await _navigateToLogoutPopUp(tester);
    await tester.pumpAndSettle();

    //Assert
    expect(find.byType(ElevatedButton), findsWidgets);
  });

  testWidgets(
      'Test all the element functionality when pop up dialog is rendered. ',
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(LoggedIn('name'));
    await tester.pumpWidget(BlocProvider.value(
      value: authBloc,
      child: const MaterialApp(
        home: Scaffold(
          drawer: NavDrawer(pageindex: 8),
        ),
      ),
    ));

    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    Future<void> _navigateToLogoutPopUp(WidgetTester tester) async {
      await tester.tap(find.text("Logout"));
      await tester.pumpAndSettle();
    }

    await _navigateToLogoutPopUp(tester);
    await tester.pumpAndSettle();

    //Assert
    expect(find.byKey(const Key('logout title')), findsWidgets);
    expect(find.byKey(const Key('Yes button')), findsWidgets);
    expect(find.byKey(const Key('cancel button')), findsWidgets);
  });

  testWidgets('Test that yes button works', (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(LoggedIn('name'));
    await tester.pumpWidget(BlocProvider.value(
      value: authBloc,
      child: const MaterialApp(
        home: Scaffold(
          drawer: NavDrawer(pageindex: 8),
        ),
      ),
    ));

    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    Future<void> _navigateToLogoutPopUp(WidgetTester tester) async {
      await tester.tap(find.text("Logout"));
      await tester.pumpAndSettle();
    }

    await _navigateToLogoutPopUp(tester);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('Yes button')));
    await tester.pumpAndSettle(const Duration(seconds: 4));

    expect(find.byType(LogoutAlert), findsNothing);
    verify(
      () => authBloc.add(AuthLogOut()),
    ).called(1);
  });

  testWidgets('Test that cancel button works', (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(LoggedIn('name'));
    await tester.pumpWidget(BlocProvider.value(
      value: authBloc,
      child: const MaterialApp(
        home: Scaffold(
          drawer: NavDrawer(pageindex: 8),
        ),
      ),
    ));

    final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    Future<void> _navigateToLogoutPopUp(WidgetTester tester) async {
      await tester.tap(find.text("Logout"));
      await tester.pumpAndSettle();
    }

    await _navigateToLogoutPopUp(tester);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('cancel button')));
    await tester.pumpAndSettle(const Duration(seconds: 4));

    expect(find.byType(LogoutAlert), findsNothing);
    verifyNever(
      () => authBloc.add(AuthLogOut()),
    ).called(0);
  });
}
