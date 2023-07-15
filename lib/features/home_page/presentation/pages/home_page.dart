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
import 'package:dcvc_flutter/features/side_navigation_bar/presentation/pages/side_bar_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dcvc_flutter/features/notifications/pages/notifications_page.dart';
import 'package:hexcolor/hexcolor.dart';
import '../widgets/carousel.dart';

class HomePage extends StatefulWidget {
  static const navigateToVaccineInfoGuid = Key('navigateToVaccineInfoGuid');
  static const navigateToBookNow = Key('navigateToBookNow');
  static const navigateToNotifications = Key('navigateToNotifications');

  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: const NavDrawer(pageindex: 0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: Builder(builder: (BuildContext context) {
          return Padding(
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
                  child: Center(
                    child: IconButton(
                      key: const Key("BackButton"),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Center(child: Icon(Icons.menu_rounded)),
                      iconSize: 17,
                      color: Colors.black,
                    ),
                  )));
        }),
        actions: [
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Visibility(
                visible: state is LoggedIn ? true : false,
                child: IconButton(
                  padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
                  key: HomePage.navigateToNotifications,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationsPage(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.circle_notifications,
                    color: HexColor('27B88D'),
                    size: 37.5,
                  ),
                ),
              );
            },
          )
        ],
        title: const Text(
          'Welcome',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: const Carousel(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: InkWell(
              key: HomePage.navigateToVaccineInfoGuid,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FlutterLogo()),
                );
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      const Positioned.fill(
                        child: Card(
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('/needle.png'),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Vaccine Guide',
                                    textAlign: TextAlign.left,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '\n Discover more information \n on various immunizations \n and vaccine types',
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xff868686),
                                      fontSize: 14,
                                      letterSpacing: 0.60,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {},
              builder: (context, state) {
                return ElevatedButton(
                  key: HomePage.navigateToBookNow,
                  onPressed: state is LoggedIn
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FlutterLogo(),
                            ),
                          );
                        }
                      : null,
                  child: const Text(
                    "Book Now",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(370, 50),
                    primary: HexColor('27B88D'),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
