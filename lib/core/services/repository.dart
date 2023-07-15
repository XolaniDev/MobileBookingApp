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

import 'package:dcvc_flutter/features/login/data/login.dart';
import 'package:dcvc_flutter/features/register/data/user.dart';
import 'package:http/http.dart' as http;

class Repository {
  final http.Client client;
  final String url = 'http://localhost:8000/';

  Repository({required this.client});

  Future<List>loginUser(Login login) async {
    var body = login.toJson();
    var response =
        await client.post(Uri.parse(url + 'v1'), body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      login.getandSaveToken(result['token'], result['name'], result['expirationTime']);
      return [true];
    }

    return [false, response.body];
  }

  Future<List> registerUser(User user) async {
    var body = user.toJson();
    final response = await client.post(
      Uri.parse(url + 'api/Register'),
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    switch (response.statusCode) {
      case 201:
        return [true];
      default:
        return [false, response.body];
    }
  }
}