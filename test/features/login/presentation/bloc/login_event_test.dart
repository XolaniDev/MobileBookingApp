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
import 'package:flutter_test/flutter_test.dart';

void main() {
  const idnumber = 'mock-idnumber';
  const password = 'mock-password';
  group('LoginEvent', () {
    group('LoginUsernameChanged', () {
      test('supports value comparisons', () {
        expect(const LoginIdentificationNumberChanged(idnumber), const LoginIdentificationNumberChanged(idnumber));
      });
    });

    group('LoginPasswordChanged', () {
      test('supports value comparisons', () {
        expect(const LoginPasswordChanged(password), const LoginPasswordChanged(password));
      });
    });

    group('LoginSubmitted', () {
      test('supports value comparisons', () {
        expect(const LoginSubmitted(), const LoginSubmitted());
      });
    });
  });
}