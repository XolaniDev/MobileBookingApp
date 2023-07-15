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

import 'package:dcvc_flutter/features/side_navigation_bar/data/user_local_data_source.dart';
import 'package:dcvc_flutter/features/side_navigation_bar/data/user_model.dart';
import 'package:dcvc_flutter/features/side_navigation_bar/data/user_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

void main() {
  late UserRepositoryImpl repositoryImpl;
  late MockUserLocalDataSource mockUserLocalDataSource;

  setUp(() {
    mockUserLocalDataSource = MockUserLocalDataSource();
    repositoryImpl =
        UserRepositoryImpl(localDataSource: mockUserLocalDataSource);
  });

  group('getUser', () {
    final userModel = UserModel('John Smith', DateTime(2021, 1, 1), 'token');

    test('should get user', () async {
      // arrange
      when(() => mockUserLocalDataSource.getUser())
          .thenAnswer((_) async => userModel);

      // act
      final result = await repositoryImpl.getUserName();

      // assert
      verify(() => mockUserLocalDataSource.getUser()).called(1);
      expect(result, userModel.name);
    });

    test('should get correct user that issues request based on the token',
        () async {
      // arrange
      when(() => mockUserLocalDataSource.getUser())
          .thenAnswer((_) async => userModel);

      // act
      final result = await repositoryImpl.getUserToken();

      // assert
      verify(() => mockUserLocalDataSource.getUser()).called(1);
      expect(result, userModel.token);
    });
  });
}
