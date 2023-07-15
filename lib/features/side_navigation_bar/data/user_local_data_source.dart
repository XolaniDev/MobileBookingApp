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

import 'dart:convert';
import '../../side_navigation_bar/data/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<UserModel?> getUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;
  const UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel?> getUser() async {
    final token = sharedPreferences.getString('token');
    final name = sharedPreferences.getString('name');
    final date = sharedPreferences.getString('date');

    if (token == null || name == null || date == null) return null;

    return UserModel(name, DateTime.parse(date), token);
  }
}
