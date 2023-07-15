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

import 'package:dcvc_flutter/features/login/domain/models/models.dart';
import 'package:dcvc_flutter/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';

void main() {
  const idnumber = IdNumber.dirty('idnumber ');
  const password = Password.dirty('password');
  group('LoginState', () {
    test('supports value comparisons', () {
      expect(const LoginState(), const LoginState());
    });

    test('returns same object when no properties are passed', () {
      expect(const LoginState().copyWith(), const LoginState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        const LoginState().copyWith(status: FormzStatus.pure),
        const LoginState(status: FormzStatus.pure),
      );
    });

    test('returns object with updated username when username is passed', () {
      expect(
        const LoginState().copyWith(idnumber : idnumber ),
        const LoginState(idnumber :idnumber ),
      );
    });

    test('returns object with updated password when password is passed', () {
      expect(
        const LoginState().copyWith(password: password),
        const LoginState(password: password),
      );
    });
  });
}