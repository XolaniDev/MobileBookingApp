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

import 'package:dcvc_flutter/core/services/repository.dart';
import 'package:dcvc_flutter/features/login/data/login.dart';
import 'package:dcvc_flutter/features/register/data/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

void main() {
  late Client mockClient;
  late Repository repository;

  setUpAll(() {
    registerFallbackValue(Uri.parse(''));
    registerFallbackValue({'x': 'h'});
    mockClient = MockClient();
    repository = Repository(client: mockClient);
  });
  
  group('registerUser', () {
    var user = User(
        checkbox: true,
        confirmPassword: '',
        fullName: '',
        idNumber: '',
        mobileNumber: '',
        password: '');

    test('should return [true]', () async {
      // arrange
      when(
        () => mockClient.post(
          any(),
          body: jsonEncode(user.toJson()),
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      ).thenAnswer((_) => Future.value(Response('true', 201)));

      // act
      var result = await repository.registerUser(user);

      // assert
      expect(result, isA<List>());
      expect(result, [true]);
    });

    test('should return [false, response.body]', () async {
      // arrange
      when(
        () => mockClient.post(
          any(),
          body: jsonEncode(user.toJson()),
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      ).thenAnswer((_) => Future.value(Response('ID already exists.', 400)));

      // act
      var result = await repository.registerUser(user);

      // assert
      expect(result, isA<List>());
      expect(result, [false, 'ID already exists.']);
    });
  });
  
  group('LoginUser', () {
    var login = Login(idNumber: '', password: '');

    test('should return [false, response.body]', () async {
      // arrange
      when(
        () => mockClient.post(
          any(),
          body: jsonEncode(login.toJson()),
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      ).thenAnswer((_) => Future.value(Response('ID already exists.', 400)));

      // act
      var result = await repository.loginUser(login);

      // assert
      expect(result, isA<List>());
      expect(result, [false, 'ID already exists.']);
    });

    test('should return true when token is saved', () async {
      when(
        () => mockClient.post(
          any(),
          body: jsonEncode(login.toJson()),
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      ).thenAnswer((_) =>
          Future.value(Response('{"token":"token" , "name":"name", "expirationTime":"${DateTime.now().toString()}"}', 200)));

      var result = await repository.loginUser(login);

      expect(result, [true]);
    });
  });
}
