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
import 'package:dcvc_flutter/features/side_navigation_bar/domain/get_user_name.dart';
import 'package:dcvc_flutter/features/side_navigation_bar/domain/user.dart';
import 'package:dcvc_flutter/features/side_navigation_bar/domain/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late GetUserName getUserName;
  late UserRepository mockUserRepository;

  setUpAll(() {
    mockUserRepository = MockUserRepository();
    getUserName = GetUserName(mockUserRepository);
  });

  final user = User('name', DateTime(2021, 1, 1), 'token');

  test('should get user name from repository', () async {
    // arrange
    when(() => mockUserRepository.getUserName())
        .thenAnswer((_) async => user.name);

    // act
    final result = await getUserName();

    // assert
    expect(result, user.name);
    verify(() => mockUserRepository.getUserName()).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });
}
