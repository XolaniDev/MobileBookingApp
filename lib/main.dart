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

import 'package:dcvc_flutter/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/bloc/authentication/auth_bloc.dart';
import 'features/register/presentation/bloc/register_bloc.dart';
import 'injection_container.dart' as dependency_injection;
import 'features/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                dependency_injection.serviceLocator<AuthBloc>()
          ),
          BlocProvider(
            create: (context) =>
                dependency_injection.serviceLocator<LoginBloc>()
          ),
          BlocProvider(
            create: (context) =>
                dependency_injection.serviceLocator<RegisterBloc>()
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Digitized Child Vaccine Card',
          theme: ThemeData(
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Lato',
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Color(0xffd5ede8),
            ),
            textTheme: const TextTheme(
              headline1: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              button: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 24.0,
              ),
              iconTheme: IconThemeData(color: Colors.black),
            ),
          ),
          home: const SplashScreen(),
        ));
  }
}
