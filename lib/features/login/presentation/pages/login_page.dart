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

import 'package:dcvc_flutter/features/home_page/presentation/pages/home_page.dart';
import 'package:dcvc_flutter/features/login/presentation/widgets/bottom_sheet.dart';
import 'package:dcvc_flutter/features/login/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('D5EDE8'),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
          child: Container(
            width: 34,
            height: 34,
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 0.6),
                  blurRadius: 4.0,
                )
              ],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0x00000000),
                width: 1,
              ),
            ),
            child: IconButton(
              key: const Key('Back Button'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              icon: const Icon(Icons.arrow_back_ios_new),
              iconSize: 17,
              color: Colors.grey,
            ),
          ),
        ),
      ),
      body: Container(
        color: HexColor("D5EDE8"),
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
              alignment: Alignment.topLeft,
              child: Text(
                "Welcome to your digitized Child Vaccine Card",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: HexColor("000000"),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.fromLTRB(15, 25, 15, 60),
              child: Text(
                "Your health and safety in the palm of your hand",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: HexColor("4AAE98"),
                ),
              ),
            ),
            const LoginForm(),
          ],
        ),
      ),
      bottomSheet: const BottomSheetCard(),
    );
  }
}
