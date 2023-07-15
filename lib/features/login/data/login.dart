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
import 'package:shared_preferences/shared_preferences.dart';

class Login {
  final String idNumber;
  final String password;

  Login({
    required this.idNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'identificationNumber': idNumber,
      'password': password,
    };
  }

  void getandSaveToken(String token, String name, String date) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('token', token);
  _prefs.setString('name', name);
  _prefs.setString('date', date);

}

}


