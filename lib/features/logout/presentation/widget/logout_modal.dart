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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

enum DialogAction { yes, abort }

class LogoutAlert {
  static Future<DialogAction> yesAbortDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            title: Text(
              title,
              key: const Key('logout title'),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            content: Text(
              body,
              style: const TextStyle(
                fontSize: 1,
              ),
            ),
            actions: <Widget>[
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        key: const Key('Yes button'),
                        onPressed: () {
                          Navigator.of(context).pop(DialogAction.yes);
                          context.read<AuthBloc>().add(AuthLogOut());
                        },
                        child: const Text('Yes, Logout'),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(5),
                            shadowColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return const Color(0xff27b88d);
                                } else {
                                  return HexColor('C0E3DB');
                                }
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(250, 46))),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 10, right: 10, left: 10, bottom: 50),
                      child: ElevatedButton(
                        key: const Key('cancel button'),
                        onPressed: () =>
                            Navigator.of(context).pop(DialogAction.abort),
                        child: const Text('Cancel'),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(5),
                            shadowColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return const Color(0xff27b88d);
                                } else {
                                  return HexColor('C0E3DB');
                                }
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(250, 46))),
                      ),
                    )
                  ])
            ],
          );
        });
    return (action != null) ? action : DialogAction.abort;
  }
}
