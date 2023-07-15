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

import 'package:dcvc_flutter/features/home_page/presentation/widgets/carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  testWidgets('Carousel is rendered correctly', (WidgetTester tester) async {
    Carousel widget = const Carousel();
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: widget,
      ),
    ));

    final carouselSliderFinder = find.byType(CarouselSlider);
    final rowFinder = find.byType(Row);
    final cardFinder = find.byType(Image);

    expect(carouselSliderFinder, findsOneWidget);
    expect(rowFinder, findsOneWidget);
    expect(cardFinder, findsOneWidget);
  });
}
