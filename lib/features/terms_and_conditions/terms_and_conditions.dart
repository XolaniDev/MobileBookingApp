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
import '../terms_and_conditions/models/terms_and_conditions_model.dart';
import '../register/presentation/pages/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:async' show Future;

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);
  static const navigateToRegister = Key('navigateToRegister');
  static const topTextField = Key('topTextField');
  static const bottomText = Key('bottomTextField');

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

/// Creating a widget in the [_TermsAndConditionsState] class.
class _TermsAndConditionsState extends State<TermsAndConditionsScreen> {
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Terms and Conditions',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0x00000000),
                    width: 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x11000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(0),
                child: IconButton(
                  key: TermsAndConditionsScreen.navigateToRegister,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                  iconSize: 17,
                  color: Colors.grey,
                ),
              )),
          title: const Text('Terms and Conditions',
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.w600,
                fontFamily: 'Lato-Semibold.ttf',
                letterSpacing: 1,
              )),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: buildJsonDataList(),
        backgroundColor: Colors.white,
      ),
    );
  }

  /// Reads the Json data and stores it in a [List] format.
  Future<List<TermsAndConditionsModel>> readJsonData() async {
    final jsondata =
        await rootBundle.loadString('assets/terms_and_conditions.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => TermsAndConditionsModel.fromJson(e)).toList();
  }

  /// Builds the [ListView] with the Json data.
  FutureBuilder buildJsonDataList() {
    return FutureBuilder(
      future: readJsonData(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(child: Text("${data.error}"));
        } else if (data.hasData) {
          var items = data.data as List<TermsAndConditionsModel>;
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              key: Key('builder ${selected.toString()}'),
              // ignore: unnecessary_null_comparison
              itemCount: items == null ? 0 : items.length,
              itemBuilder: (context, index) {
                return termsAndConditionsCard(items, index, context);
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  /// Creating and formatting a [Card].
  Card termsAndConditionsCard(items, index, context) {
    return Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 9),
        child: termsAndConditionsFormat(items, index));
  }

  ///The [Column] and the [Row] help format and align the paragraphs and content within the [Card].
  Column termsAndConditionsFormat(items, index) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              items[index].heading.toString(),
              style: const TextStyle(
                color: Color(0xff00624b),
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: 'fonts/Lato-Semibold.ttf',
                letterSpacing: 1,
              ),
            ),
            Column(children: const [Text("")])
          ]),
          Text(
            items[index].paragraph.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: 'fonts/Lato-Regular.ttf',
              letterSpacing: 1,
            ),
          ),
        ]);
  }
}
