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

import 'package:bloc_test/bloc_test.dart';
import 'package:dcvc_flutter/core/services/repository.dart';
import 'package:dcvc_flutter/features/register/data/user.dart';
import 'package:dcvc_flutter/features/register/domain/models/fullname.dart';
import 'package:dcvc_flutter/features/register/domain/models/idnumber.dart';
import 'package:dcvc_flutter/features/register/domain/models/mobilenumber.dart';
import 'package:dcvc_flutter/features/register/domain/models/models.dart';
import 'package:dcvc_flutter/features/register/domain/models/password.dart';
import 'package:dcvc_flutter/features/register/presentation/bloc/register_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements Repository {}

void main() {
  late Repository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
  });

  group('RegisterBloc', () {
    test('initial state is RegisterState', () {
      final registerBloc = RegisterBloc(repository: mockRepository);
      expect(registerBloc.state, const RegisterState());
    });

    group('RegisterSubmitted', () {
      blocTest<RegisterBloc, RegisterState>(
        'emits [submissionInProgress, submissionSuccess] when register succeeds',
        setUp: () {
          registerFallbackValue(User(
            fullName: 'John Smith',
            email: 'john.smith@email.com',
            idNumber: '0001010000006',
            mobileNumber: '0123456789',
            confirmPassword: 'Password1@',
            password: 'Password1@',
            checkbox: true,
          ));
        },
        build: () {
          when(() => mockRepository.registerUser(any()))
              .thenAnswer((_) => Future.value([true]));
          return RegisterBloc(repository: mockRepository);
        },
        act: (bloc) {
          bloc
            ..add(const RegisterFullNameChanged('John Smith'))
            ..add(const RegisterEmailChanged('john.smith@email.com'))
            ..add(const RegisterIdentificationNumberChanged('0001010000006'))
            ..add(const RegisterMobileNumberChanged('0123456789'))
            ..add(const RegisterPasswordChanged('Password1@'))
            ..add(const RegisterConfirmPasswordChanged('Password1@'))
            ..add(const RegisterCheckboxChecked(true))
            ..add(const RegisterCheckboxChecked(false))
            ..add(const RegisterCheckboxChecked(true))
            ..add(const RegisterSubmitted());
        },
        expect: () => const <RegisterState>[
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            password: Password.dirty('Password1@'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            password: Password.dirty('Password1@'),
            confirmpassword: ConfirmPassword.dirty('Password1@'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            password: Password.dirty('Password1@'),
            confirmpassword: ConfirmPassword.dirty('Password1@'),
            checkbox: Checkbox.dirty(true),
            status: FormzStatus.valid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            password: Password.dirty('Password1@'),
            confirmpassword: ConfirmPassword.dirty('Password1@'),
            checkbox: Checkbox.dirty(false),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            password: Password.dirty('Password1@'),
            confirmpassword: ConfirmPassword.dirty('Password1@'),
            checkbox: Checkbox.dirty(true),
            status: FormzStatus.valid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            password: Password.dirty('Password1@'),
            confirmpassword: ConfirmPassword.dirty('Password1@'),
            checkbox: Checkbox.dirty(true),
            status: FormzStatus.submissionInProgress,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            password: Password.dirty('Password1@'),
            confirmpassword: ConfirmPassword.dirty('Password1@'),
            checkbox: Checkbox.dirty(true),
            status: FormzStatus.submissionSuccess,
          ),
        ],
      );
      blocTest<RegisterBloc, RegisterState>(
        'emits [submissionFailuter] when connection to repository fails',
        setUp: () {
          registerFallbackValue(User(
            fullName: 'John Smith',
            email: 'john.smith@email.com',
            idNumber: '0001010000006',
            mobileNumber: '0123456789',
            confirmPassword: 'Password1@',
            password: 'Password1@',
            checkbox: true,
          ));
        },
        build: () {
          when(() => mockRepository.registerUser(any())).thenThrow('error');
          return RegisterBloc(repository: mockRepository);
        },
        act: (bloc) {
          bloc
            ..add(const RegisterFullNameChanged('John Smith'))
            ..add(const RegisterEmailChanged('john.smith@email.com'))
            ..add(const RegisterIdentificationNumberChanged('0001010000006'))
            ..add(const RegisterMobileNumberChanged('0123456789'))
            ..add(const RegisterPasswordChanged('Password1@'))
            ..add(const RegisterConfirmPasswordChanged('Password1@'))
            ..add(const RegisterCheckboxChecked(true))
            ..add(const RegisterSubmitted());
        },
        expect: () => const <RegisterState>[
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            password: Password.dirty('Password1@'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            password: Password.dirty('Password1@'),
            confirmpassword: ConfirmPassword.dirty('Password1@'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            password: Password.dirty('Password1@'),
            confirmpassword: ConfirmPassword.dirty('Password1@'),
            checkbox: Checkbox.dirty(true),
            status: FormzStatus.valid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            password: Password.dirty('Password1@'),
            confirmpassword: ConfirmPassword.dirty('Password1@'),
            checkbox: Checkbox.dirty(true),
            status: FormzStatus.submissionInProgress,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            password: Password.dirty('Password1@'),
            confirmpassword: ConfirmPassword.dirty('Password1@'),
            checkbox: Checkbox.dirty(true),
            status: FormzStatus.submissionFailure,
          ),
        ],
      );
      blocTest<RegisterBloc, RegisterState>(
        'emits [submissionInProgress, submissionFailure] when register fails',
        setUp: () {
          registerFallbackValue(User(
            fullName: 'John Smith',
            email: 'john.smith@email.com',
            idNumber: '0001010000006',
            mobileNumber: '0123456789',
            confirmPassword: 'Password1@',
            password: 'Password1@',
            checkbox: true,
          ));
        },
        build: () {
          when(() => mockRepository.registerUser(any()))
              .thenAnswer((_) => Future.value([false, 'ID already exists']));
          return RegisterBloc(repository: mockRepository);
        },
        act: (bloc) {
          bloc
            ..add(const RegisterFullNameChanged('John Smith'))
            ..add(const RegisterEmailChanged('john.smith@email.com'))
            ..add(const RegisterIdentificationNumberChanged('0001010000006'))
            ..add(const RegisterMobileNumberChanged('0123456789'))
            ..add(const RegisterPasswordChanged('Password1@'))
            ..add(const RegisterConfirmPasswordChanged('Password1@'))
            ..add(const RegisterCheckboxChecked(true))
            ..add(const RegisterSubmitted());
        },
        expect: () => const <RegisterState>[
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            password: Password.dirty('Password1@'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            password: Password.dirty('Password1@'),
            confirmpassword: ConfirmPassword.dirty('Password1@'),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            password: Password.dirty('Password1@'),
            confirmpassword: ConfirmPassword.dirty('Password1@'),
            checkbox: Checkbox.dirty(true),
            status: FormzStatus.valid,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            password: Password.dirty('Password1@'),
            confirmpassword: ConfirmPassword.dirty('Password1@'),
            checkbox: Checkbox.dirty(true),
            status: FormzStatus.submissionInProgress,
          ),
          RegisterState(
            fullname: Fullname.dirty('John Smith'),
            email: Email.dirty('john.smith@email.com'),
            idnumber: IdNumber.dirty('0001010000006'),
            mobilenumber: MobileNumber.dirty('0123456789'),
            password: Password.dirty('Password1@'),
            confirmpassword: ConfirmPassword.dirty('Password1@'),
            checkbox: Checkbox.dirty(true),
            status: FormzStatus.submissionFailure,
          ),
        ],
      );
    });

    group('Unfocused and visibility events', () {
      blocTest<RegisterBloc, RegisterState>(
        'form invalid when no changes made after tapping in field',
        build: () => RegisterBloc(repository: mockRepository),
        act: (bloc) {
          bloc
            ..add(RegisterFullNameUnfocused())
            ..add(RegisterIdNumberUnfocused())
            ..add(RegisterEmailUnfocused())
            ..add(RegisterMobileNumberUnfocused())
            ..add(RegisterPasswordUnfocused())
            ..add(RegisterPasswordVisibilityChanged())
            ..add(RegisterPasswordVisibilityChanged())
            ..add(RegisterConfirmPasswordUnfocused())
            ..add(RegisterConfirmPasswordVisibilityChanged())
            ..add(RegisterConfirmPasswordVisibilityChanged());
        },
        expect: () => const <RegisterState>[
          RegisterState(
            fullname: Fullname.dirty(),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty(),
            idnumber: IdNumber.dirty(),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty(),
            idnumber: IdNumber.dirty(),
            email: Email.dirty(),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty(),
            idnumber: IdNumber.dirty(),
            email: Email.dirty(),
            mobilenumber: MobileNumber.dirty(),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty(),
            idnumber: IdNumber.dirty(),
            email: Email.dirty(),
            mobilenumber: MobileNumber.dirty(),
            password: Password.dirty(),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty(),
            idnumber: IdNumber.dirty(),
            email: Email.dirty(),
            mobilenumber: MobileNumber.dirty(),
            password: Password.dirty(),
            passwordVisible: true,
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty(),
            idnumber: IdNumber.dirty(),
            email: Email.dirty(),
            mobilenumber: MobileNumber.dirty(),
            password: Password.dirty(),
            passwordVisible: false,
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty(),
            idnumber: IdNumber.dirty(),
            email: Email.dirty(),
            mobilenumber: MobileNumber.dirty(),
            password: Password.dirty(),
            passwordVisible: false,
            confirmpassword: ConfirmPassword.dirty(),
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty(),
            idnumber: IdNumber.dirty(),
            email: Email.dirty(),
            mobilenumber: MobileNumber.dirty(),
            password: Password.dirty(),
            passwordVisible: false,
            confirmpassword: ConfirmPassword.dirty(),
            confirmPasswordVisible: true,
            status: FormzStatus.invalid,
          ),
          RegisterState(
            fullname: Fullname.dirty(),
            idnumber: IdNumber.dirty(),
            email: Email.dirty(),
            mobilenumber: MobileNumber.dirty(),
            password: Password.dirty(),
            passwordVisible: false,
            confirmpassword: ConfirmPassword.dirty(),
            confirmPasswordVisible: false,
            status: FormzStatus.invalid,
          ),
        ],
      );
    });
  });
}
