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

enum ConfirmPasswordValidationError { invalid }

class ConfirmPassword extends FormzInput<String, ConfirmPasswordValidationError> {
  const ConfirmPassword.pure([String value = '']) : super.pure(value);
  const ConfirmPassword.dirty([String value = '']) : super.dirty(value);

  static final _confirmpasswordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$'
      );

  @override
  ConfirmPasswordValidationError? validator(String? value) {
    return _confirmpasswordRegex.hasMatch(value ?? '')
        ? null
        : ConfirmPasswordValidationError.invalid;
  }
}
