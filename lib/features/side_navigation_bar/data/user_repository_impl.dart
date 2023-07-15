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

import '../../side_navigation_bar/data/user_local_data_source.dart';
import '../../side_navigation_bar/domain/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;
  const UserRepositoryImpl({required this.localDataSource});

  @override
  Future<String?> getUserName() async {
    final result = await localDataSource.getUser();
    return result?.name;
  }

  Future<String?> getUserToken() async {
    final result = await localDataSource.getUser();
    return result?.token;
  }
}
