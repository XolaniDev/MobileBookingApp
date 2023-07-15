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

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dcvc_flutter/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Tests if the splash screen renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final Finder splashScreen = find.byType(AnimatedSplashScreen);

    expect(splashScreen, findsOneWidget);
  });

  testWidgets('Test if it finds the image on the splash screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    var elementWithImage = '';
    var elements = tester.allElements;
    for (var item in elements) {
      if (item.toString().contains('_ScrollNotificationObserverScope')) {
        elementWithImage = item.toStringDeep();
      }
    }
    expect(elementWithImage.contains('assets/splash.png'), true);
  });
}
