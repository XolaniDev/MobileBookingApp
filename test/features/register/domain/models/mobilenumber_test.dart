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

import 'package:dcvc_flutter/features/register/domain/models/mobilenumber.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mobileNumberString = '0711234567';
  group('Mobile Number', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const mobileNumber = MobileNumber.pure();
        expect(mobileNumber.value, '');
        expect(mobileNumber.pure, true);
      });

      test('dirty creates correct instance', () {
        const mobileNumber = MobileNumber.dirty(mobileNumberString);
        expect(mobileNumber.value, mobileNumberString);
        expect(mobileNumber.pure, false);
      });
    });

      test('is valid when Mobile Number is not empty', () {
        expect(
          const MobileNumber.dirty(mobileNumberString).error,
          isNull,
        );
      });
    });
}