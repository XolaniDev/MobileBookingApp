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

import 'package:dcvc_flutter/features/register/domain/models/fullname.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const fullnameString = 'Gary Smith';
  group('Fullname', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const fullname = Fullname.pure();
        expect(fullname.value, '');
        expect(fullname.pure, true);
      });

      test('dirty creates correct instance', () {
        const fullname = Fullname.dirty(fullnameString);
        expect(fullname.value, fullnameString);
        expect(fullname.pure, false);
      });
    });

      test('is valid when username is not empty', () {
        expect(
          const Fullname.dirty(fullnameString).error,
          isNull,
        );
      });
    });
}