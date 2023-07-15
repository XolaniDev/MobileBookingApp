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
import 'package:flutter_test/flutter_test.dart';

void main() {
  const idnumberString = 'mock-idnumber';
  group('IdNumber', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const idnumber = IdNumber.pure();
        expect(idnumber.value, '');
        expect(idnumber.pure, true);
      });

      test('dirty creates correct instance', () {
        const idnumber = IdNumber.dirty(idnumberString);
        expect(idnumber.value, idnumberString);
        expect(idnumber.pure, false);
      });
    });
  });
}
