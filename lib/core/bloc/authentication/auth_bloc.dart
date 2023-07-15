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

import 'package:dcvc_flutter/features/logout/data/log_out.dart';
import 'package:dcvc_flutter/features/side_navigation_bar/domain/get_user_name.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  GetUserName getUserName;
  Logout logout;

  AuthBloc({required this.getUserName, required this.logout}) : super(NotLoggedIn()) {
    on<AuthLogIn>(_onLogIn);
    on<AuthLogOut>(_onLogOut);
  }

  void _onLogIn(
    AuthLogIn event,
    Emitter<AuthState> emit,
  ) async {
    final name = await getUserName();
    emit(LoggedIn(name));
  }

  void _onLogOut(
    AuthLogOut event,
    Emitter<AuthState> emit,
  ) async {
    await logout.removeSavedPref();
    emit(NotLoggedIn());
  }
}
