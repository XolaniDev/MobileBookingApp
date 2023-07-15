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

import 'package:formz/formz.dart';

enum FullValidationError { invalid }

class Fullname extends FormzInput<String, FullValidationError> {
  const Fullname.pure([String value = '']) : super.pure(value);
  const Fullname.dirty([String value = '']) : super.dirty(value);

  static final _fullnameRegex = RegExp(
      r'^[a-z A-Z]+ [a-z A-Z /s]+$');

  @override
  FullValidationError? validator(String? value) {
    return _fullnameRegex.hasMatch(value ?? '')
        ? null
        : FullValidationError.invalid;
  }
}
