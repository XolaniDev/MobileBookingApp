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

enum MobileNumberValidationError { invalid }

class MobileNumber extends FormzInput<String, MobileNumberValidationError> {
  const MobileNumber.pure([String value = '']) : super.pure(value);
  const MobileNumber.dirty([String value = '']) : super.dirty(value);

  static final _mobilenumberRegex = RegExp(
    r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$',
  );

  @override
  MobileNumberValidationError? validator(String? value) {
    return _mobilenumberRegex.hasMatch(value ?? '')
        ? null
        : MobileNumberValidationError.invalid;
  }
}
