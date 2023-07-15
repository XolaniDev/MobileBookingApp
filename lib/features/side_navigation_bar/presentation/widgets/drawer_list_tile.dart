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

import 'package:flutter/material.dart';

class DrawerListTile extends ListTile {
  DrawerListTile({
    Key? key,
    bool enabled = true,
    required Widget leading,
    required String title,
    void Function()? onTap,
    bool selected = false,
  }) : super(
          key: key,
          enabled: enabled,
          leading: IconTheme(
            data: IconThemeData(
              color:
                  enabled ? const Color(0xff0d735a) : const Color(0xffb4c9c4),
            ),
            child: leading,
          ),
          title: Text(
            title,
            style: TextStyle(
              color:
                  enabled ? const Color(0xff0d735a) : const Color(0xffb4c9c4),
            ),
          ),
          onTap: onTap,
          selected: selected,
        );
}
