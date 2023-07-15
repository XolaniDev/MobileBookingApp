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
import 'package:dcvc_flutter/features/register/domain/models/password.dart';
import 'package:dcvc_flutter/features/register/domain/models/email.dart';
import 'package:dcvc_flutter/features/register/domain/models/mobilenumber.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:dcvc_flutter/features/register/presentation/bloc/register_bloc.dart';
import 'package:dcvc_flutter/features/register/domain/models/idnumber.dart';
import 'package:dcvc_flutter/features/register/domain/models/confirmpassword.dart';
import 'package:dcvc_flutter/features/register/domain/models/checkbox.dart';

void main() {
  const fullname = Fullname.dirty('George Patterson');
  const password = Password.dirty('Password1!');
  const email = Email.dirty('sally@gmail.com');
  const mobilenumber = MobileNumber.dirty('0711234567');
  const idnumber = IdNumber.dirty('9903011234567');
  const confirmpassword = ConfirmPassword.dirty('Password1!');
  const checkbox = Checkbox.dirty(false);
  group('RegisterState', () {
    test('supports value comparisons', () {
      expect(const RegisterState(), const RegisterState());
    });

    test('returns same object when no properties are passed', () {
      expect(const RegisterState().copyWith(), const RegisterState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        const RegisterState().copyWith(status: FormzStatus.pure),
        const RegisterState(status: FormzStatus.pure),
      );
    });

    test('returns object with updated fullname when fullname is passed', () {
      expect(
        const RegisterState().copyWith(fullname: fullname),
        const RegisterState(fullname: fullname),
      );
    });

    test('returns object with updated password when password is passed', () {
      expect(
        const RegisterState().copyWith(password: password),
        const RegisterState(password: password),
      );
    });

    test('returns object with updated email when email is passed', () {
      expect(
        const RegisterState().copyWith(email: email),
        const RegisterState(email: email),
      );
    });

    test(
        'returns object with updated mobile number when mobile number is passed',
        () {
      expect(
        const RegisterState().copyWith(mobilenumber: mobilenumber),
        const RegisterState(mobilenumber: mobilenumber),
      );
    });

    test(
        'returns object with updated id-number when id-number is passed',
        () {
      expect(
        const RegisterState().copyWith(idnumber: idnumber),
        const RegisterState(idnumber: idnumber),
      );
    });

    test(
        'returns object with updated confirm password when confirm password is passed',
        () {
      expect(
        const RegisterState().copyWith(confirmpassword: confirmpassword),
        const RegisterState(confirmpassword: confirmpassword),
      );
    });

    test(
        'returns object with updated checkbox when checkbox is passed',
        () {
      expect(
        const RegisterState().copyWith(checkbox: checkbox),
        const RegisterState(checkbox: checkbox),
      );
    });
  });
}
