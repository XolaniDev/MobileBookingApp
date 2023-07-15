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

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hexcolor/hexcolor.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentIndex = 0;

  Map<String, String> ourMap = {
    'childwithteddy.png':
        'Vaccines contain dead or weakened viruses.\n Exposure to these help the body recognize and\n produce antibodies to proct against the disease.',
    'littlegirlwithtoy.png':
        'Vaccines contain dead or weakened viruses.\n Exposure to these help the body recognize and\n produce antibodies to proct against the disease.',
    'doctor.png':
        'Vaccines contain dead or weakened viruses.\n Exposure to these help the body recognize and\n produce antibodies to proct against the disease.',
  };

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 1,
              height: MediaQuery.of(context).size.height / 2.3,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              }),
          items: ourMap.entries.map((e) => buildCard(e)).toList()),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: map<Widget>(ourMap.entries.toList(), (index, url) {
          return Container(
            width: 10.0,
            height: 10.0,
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentIndex == index ? HexColor('27B88D') : Colors.grey,
            ),
          );
        }),
      ),
    ]);
  }

  Widget buildCard(MapEntry<String, String> entry) {
    Widget card = Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                '/' + entry.key,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
            width: 215,
            height: 63,
            child: Text(
              "Vaccines contain dead or weakened viruses. Exposure to these help the body recognize and produce antibodies to protect again the disease.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: "Lato",
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),
        )
      ],
    );
    return card;
  }
}
