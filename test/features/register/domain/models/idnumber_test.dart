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

import 'package:dcvc_flutter/features/register/domain/models/idnumber.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const idString = '9903011234567';
  group('ID', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const id = IdNumber.pure();
        expect(id.value, '');
        expect(id.pure, true);
      });

      test('dirty creates correct instance', () {
        const id = IdNumber.dirty(idString);
        expect(id.value, idString);
        expect(id.pure, false);
      });
    });

      test('is valid when id is not empty', () {
        expect(
          const IdNumber.dirty(idString).error,
          isNull,
        );
      });
    });
}