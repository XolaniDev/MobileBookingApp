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

import 'package:dcvc_flutter/features/register/domain/models/confirmpassword.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const confirmPasswordString = 'Password1!';
  group('Confirm Password', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const confirmPassword = ConfirmPassword.pure();
        expect(confirmPassword.value, '');
        expect(confirmPassword.pure, true);
      });

      test('dirty creates correct instance', () {
        const confirmPassword = ConfirmPassword.dirty(confirmPasswordString);
        expect(confirmPassword.value, confirmPasswordString);
        expect(confirmPassword.pure, false);
      });
    });

      test('is valid when confirm password is not empty', () {
        expect(
          const ConfirmPassword.dirty(confirmPasswordString).error,
          isNull,
        );
      });
    });
}