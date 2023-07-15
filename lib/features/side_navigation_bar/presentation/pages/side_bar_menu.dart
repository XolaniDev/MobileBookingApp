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
import 'package:dcvc_flutter/features/login/presentation/pages/login_page.dart';
import 'package:dcvc_flutter/features/logout/presentation/widget/logout_modal.dart';
import '/features/side_navigation_bar/presentation/widgets/drawer_list_tile.dart';
import 'package:dcvc_flutter/features/contact_us/presentation/pages/contact_us_page.dart';
import 'package:dcvc_flutter/features/home_page/presentation/pages/home_page.dart';
import 'package:dcvc_flutter/features/medical_history/presentation/pages/medical_history_page.dart';
import 'package:dcvc_flutter/features/notifications/presentation/pages/notifications_page.dart';
import 'package:dcvc_flutter/features/profile/presentation/pages/profile_page.dart';
import 'package:dcvc_flutter/features/settings/presentation/pages/settings_page.dart';
import 'package:dcvc_flutter/features/side_navigation_bar/presentation/widgets/drawer_list_tile.dart';
import 'package:dcvc_flutter/features/vaccine_card/presentation/pages/vaccine_card_page.dart';
import 'package:dcvc_flutter/features/vaccine_schedule/presentation/pages/vaccine_schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavDrawer extends StatelessWidget {
  final int _pageIndex;
  static const openDrawerKey = Key("openDrawerKey");

  const NavDrawer({Key? key, required int pageindex})
      : _pageIndex = pageindex,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      bool _isloggedin = false;
      String _name = '';
      if (state is LoggedIn) {
        _isloggedin = true;
        _name = state.name ?? '';
      }

      return Drawer(
        child: ListTileTheme(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          selectedTileColor: const Color(0x294AAE98),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide.none),
                ),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 5, top: 10, bottom: 10),
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
                              key: const Key("hamburgerButton"),
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.menu),
                              iconSize: 17,
                              color: Colors.black,
                            ),
                          )),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.account_circle,
                              size: 60,
                              color: Color(0xffdad6d6),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                'Welcome, $_name',
                                style: const TextStyle(
                                    color: Color(0xff00634c),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: <Widget>[
                  DrawerListTile(
                    leading: const Icon(
                      Icons.home,
                    ),
                    title: 'Home',
                    key: const Key("Home"),
                    selected: _pageIndex == 0,
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const HomePage(),
                        ),
                      );
                    },
                  ),
                  DrawerListTile(
                    enabled: _isloggedin,
                    leading: const Icon(Icons.person),
                    key: const Key("Profile"),
                    title: 'Profile',
                    selected: _pageIndex == 1,
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ProfilePage(),
                        ),
                      );
                    },
                  ),
                  DrawerListTile(
                    enabled: _isloggedin,
                    leading: const Icon(Icons.list_alt),
                    key: const Key("Vaccine Card"),
                    title: 'Vaccine Card',
                    selected: _pageIndex == 2,
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const VaccineCardPage(),
                        ),
                      );
                    },
                  ),
                  DrawerListTile(
                    enabled: _isloggedin,
                    leading: const Icon(
                      Icons.today,
                    ),
                    key: const Key("Vaccine Schedule"),
                    title: 'Vaccine Schedule',
                    selected: _pageIndex == 3,
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const VaccineSchedulePage(),
                        ),
                      );
                    },
                  ),
                  DrawerListTile(
                    enabled: _isloggedin,
                    leading: const Icon(Icons.local_hospital),
                    key: const Key("Medical History"),
                    title: 'Medical History',
                    selected: _pageIndex == 4,
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const MedicalHistoryPage(),
                        ),
                      );
                    },
                  ),
                  DrawerListTile(
                    enabled: _isloggedin,
                    leading: const Icon(Icons.notifications),
                    key: const Key("Notifications"),
                    title: 'Notifications',
                    selected: _pageIndex == 5,
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const NotificationsPage(),
                        ),
                      );
                    },
                  ),
                  DrawerListTile(
                    leading: const Icon(Icons.phone),
                    key: const Key("Contact Us"),
                    title: 'Contact Us',
                    selected: _pageIndex == 6,
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ContactUsPage(),
                        ),
                      );
                    },
                  ),
                  DrawerListTile(
                    leading: const Icon(Icons.settings),
                    key: const Key("Settings"),
                    title: 'Settings',
                    selected: _pageIndex == 7,
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SettingsPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DrawerListTile(
                      leading: const Icon(
                        Icons.exit_to_app,
                      ),
                      selected: _pageIndex == 8,
                      title: _isloggedin ? 'Logout' : "Login",
                      onTap: () async {
                        if (_isloggedin) {
                          final action = await LogoutAlert.yesAbortDialog(
                              context, 'Are you sure you want to logout?', '');
                          if (action == DialogAction.yes) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                    content: Row(children: const <Widget>[
                                      Icon(
                                        Icons.check_circle_outline_rounded,
                                        color: Color(0xff27b88d),
                                      ),
                                      Text(' Successfully Logged out',
                                          style: TextStyle(
                                              color: Color(0xff27b88d)))
                                    ]),
                                    backgroundColor: Colors.white,
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 5,
                                    margin: const EdgeInsets.all(5),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)))),
                              );
                          }
                        } else {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LoginPage(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
