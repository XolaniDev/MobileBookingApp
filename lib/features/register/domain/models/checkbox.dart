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

enum CheckboxValidationError { invalid }

class Checkbox extends FormzInput<bool, CheckboxValidationError> {
  const Checkbox.pure([bool value = false]) : super.pure(value);
  const Checkbox.dirty([bool value = false]) : super.dirty(value);

  @override
  CheckboxValidationError? validator(bool? value) {
    if (value != null) {
      if (!value) {
        return CheckboxValidationError.invalid;
      }
    } else {
      return CheckboxValidationError.invalid;
    }
  }
}
