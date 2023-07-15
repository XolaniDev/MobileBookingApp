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
import 'package:dcvc_flutter/features/side_navigation_bar/data/user_local_data_source.dart';
import 'package:dcvc_flutter/features/side_navigation_bar/data/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late UserLocalDataSourceImpl dataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = UserLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getUser', () {
    final userModel = UserModel('John Smith', DateTime(2021, 1, 1), 'token');

    test('should return null if no user data found ', () async {
      // arrange
      when(() => mockSharedPreferences.getString('date')).thenReturn(null);
      when(() => mockSharedPreferences.getString('token')).thenReturn(null);
      when(() => mockSharedPreferences.getString('name')).thenReturn(null);

      // act
      final result = await dataSourceImpl.getUser();

      // assert
      verify(() => mockSharedPreferences.getString('date')).called(1);
      verify(() => mockSharedPreferences.getString('token')).called(1);
      verify(() => mockSharedPreferences.getString('name')).called(1);
      expect(result, null);
    });

    test('should return user model if user data found', () async {
      // arrange
      when(() => mockSharedPreferences.getString('name'))
          .thenAnswer((_) => userModel.name);
      when(() => mockSharedPreferences.getString('date'))
          .thenAnswer((_) => userModel.date.toString());
      when(() => mockSharedPreferences.getString('token'))
          .thenAnswer((_) => userModel.token);

      // act
      final result = await dataSourceImpl.getUser();

      // assert
      verify(() => mockSharedPreferences.getString('name')).called(1);
      verify(() => mockSharedPreferences.getString('date')).called(1);
      verify(() => mockSharedPreferences.getString('token')).called(1);
      expect(result, userModel);
    });
  });
}
