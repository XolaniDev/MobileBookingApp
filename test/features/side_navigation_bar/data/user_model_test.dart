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
import 'package:dcvc_flutter/features/side_navigation_bar/data/user_model.dart';
import 'package:dcvc_flutter/features/side_navigation_bar/domain/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final userModel = UserModel('John Smith', DateTime(2021, 1, 1), 'token');

  String _encode(Object object) =>
      const JsonEncoder.withIndent(' ').convert(object);

  test('subclass of User entity', () async {
    expect(userModel, isA<User>());
  });

  group('fromJson', () {
    test(
      'should return a valid model when JSON full name is a string',
      () async {
        // act
        final userModelJson = _encode(userModel);
        final userModel2 = UserModel.fromJson(
            json.decode(userModelJson) as Map<String, dynamic>);

        // assert
        expect(userModel.name, userModel2.name);
        expect(userModel.date, userModel2.date);
        expect(userModel.token, userModel2.token);
        expect(_encode(userModel2), equals(userModelJson));
      },
    );
  });

  group('toJson', () {
    test(
      'should return a Json map containing the proper data',
      () async {
        // act
        final result = userModel.toJson();
        final expectedJsonMap = {
          "token": "token",
          "date": '2021-01-01T00:00:00.000',
          "name": 'John Smith',
        };

        // assert
        expect(result, expectedJsonMap);
      },
    );
  });
}
