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

import 'package:dcvc_flutter/core/bloc/authentication/auth_bloc.dart';
import 'package:dcvc_flutter/features/logout/data/log_out.dart';
import 'package:dcvc_flutter/features/login/presentation/bloc/login_bloc.dart';
import 'package:dcvc_flutter/features/register/presentation/bloc/register_bloc.dart';
import 'package:dcvc_flutter/features/side_navigation_bar/data/user_local_data_source.dart';
import 'package:dcvc_flutter/features/side_navigation_bar/data/user_repository_impl.dart';
import 'package:dcvc_flutter/features/side_navigation_bar/domain/get_user_name.dart';
import 'package:dcvc_flutter/features/side_navigation_bar/domain/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'core/services/repository.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerFactory(
    () => AuthBloc(
      getUserName: serviceLocator(),
      logout: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(() => LoginBloc(repository: serviceLocator()));
  serviceLocator
      .registerFactory(() => RegisterBloc(repository: serviceLocator()));

  serviceLocator.registerLazySingleton(() => GetUserName(serviceLocator()));
  serviceLocator.registerLazySingleton(() => Logout());

  serviceLocator.registerLazySingleton(
    () => Repository(client: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(localDataSource: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sharedPreferences: serviceLocator()),
  );

  final sharedPrefernces = await SharedPreferences.getInstance();

  serviceLocator.registerLazySingleton(() => sharedPrefernces);
  serviceLocator.registerLazySingleton(() => http.Client());
}
