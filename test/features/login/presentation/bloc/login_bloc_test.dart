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
import 'package:dcvc_flutter/features/login/data/login.dart';
import 'package:dcvc_flutter/features/login/domain/models/models.dart';
import 'package:dcvc_flutter/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements Repository {}

void main() {
  late Repository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
  });

  group('LoginBloc', () {
    test('initial state is the LoginState', () {
      final loginBloc = LoginBloc(
        repository: mockRepository,
      );
      expect(loginBloc.state, const LoginState());
    });
  });

  group('LoginSubmitted', () {
    blocTest<LoginBloc, LoginState>(
      'emits [submissionInProgress, submissionSuccess] '
      'when login succeeds',
      setUp: () {
        registerFallbackValue(Login(
          idNumber: '0001010000006',
          password: 'Genn@M12',
        ));
      },
      build: () {
        when(() => mockRepository.loginUser(any()))
            .thenAnswer((_) => Future.value([true]));
        return LoginBloc(repository: mockRepository);
      },
      act: (bloc) {
        bloc
          ..add(const LoginIdentificationNumberChanged('0001010000006'))
          ..add(const LoginPasswordChanged('Genn@M12'))
          ..add(const LoginSubmitted());
      },
      expect: () => const <LoginState>[
        LoginState(
          idnumber: IdNumber.dirty('0001010000006'),
          status: FormzStatus.invalid,
        ),
        LoginState(
          idnumber: IdNumber.dirty('0001010000006'),
          password: Password.dirty('Genn@M12'),
          status: FormzStatus.valid,
        ),
        LoginState(
          idnumber: IdNumber.dirty('0001010000006'),
          password: Password.dirty('Genn@M12'),
          status: FormzStatus.submissionInProgress,
        ),
        LoginState(
          idnumber: IdNumber.dirty('0001010000006'),
          password: Password.dirty('Genn@M12'),
          status: FormzStatus.submissionSuccess,
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginInProgress, LoginFailure] when logIn fails',
      setUp: () {
        registerFallbackValue(Login(
          idNumber: '0001010000006',
          password: 'Genn@M12',
        ));
      },
      build: () {
        when(() => mockRepository.loginUser(any()))
            .thenThrow(Exception('oops'));

        return LoginBloc(repository: mockRepository);
      },
      act: (bloc) {
        bloc
          ..add(const LoginIdentificationNumberChanged('0001010000006'))
          ..add(const LoginPasswordChanged('Genn@M12'))
          ..add(const LoginSubmitted());
      },
      expect: () => const <LoginState>[
        LoginState(
          idnumber: IdNumber.dirty('0001010000006'),
          status: FormzStatus.invalid,
        ),
        LoginState(
          idnumber: IdNumber.dirty('0001010000006'),
          password: Password.dirty('Genn@M12'),
          status: FormzStatus.valid,
        ),
        LoginState(
          idnumber: IdNumber.dirty('0001010000006'),
          password: Password.dirty('Genn@M12'),
          status: FormzStatus.submissionInProgress,
        ),
        LoginState(
          idnumber: IdNumber.dirty('0001010000006'),
          password: Password.dirty('Genn@M12'),
          status: FormzStatus.submissionFailure,
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginInProgress, LoginFailure] when method succeeds but invalid id',
      setUp: () {
        registerFallbackValue(Login(
          idNumber: '0001010000007',
          password: 'Genn@M12',
        ));
      },
      build: () {
        when(
          () => mockRepository.loginUser(any()),
        ).thenAnswer((_) => Future.value([false, 'invalid id']));

        return LoginBloc(
          repository: mockRepository,
        );
      },
      act: (bloc) {
        bloc
          ..add(const LoginIdentificationNumberChanged('0001010000007'))
          ..add(const LoginPasswordChanged('Genn@M12'))
          ..add(const LoginSubmitted());
      },
      expect: () => const <LoginState>[
        LoginState(
          idnumber: IdNumber.dirty('0001010000007'),
          status: FormzStatus.invalid,
        ),
        LoginState(
          idnumber: IdNumber.dirty('0001010000007'),
          password: Password.dirty('Genn@M12'),
          status: FormzStatus.valid,
        ),
        LoginState(
          idnumber: IdNumber.dirty('0001010000007'),
          password: Password.dirty('Genn@M12'),
          status: FormzStatus.submissionInProgress,
        ),
        LoginState(
          idnumber: IdNumber.dirty('0001010000007'),
          password: Password.dirty('Genn@M12'),
          status: FormzStatus.submissionFailure,
        ),
      ],
    );

    group('Unfocused and visibility events', () {
      blocTest<LoginBloc, LoginState>(
        'form invalid when no changes made after tapping in field',
        build: () => LoginBloc(repository: mockRepository),
        act: (bloc) {
          bloc
            ..add(LoginIdNumberUnfocused())
            ..add(LoginPasswordUnfocused())
            ..add(LoginPasswordVisibilityChanged())
            ..add(LoginPasswordVisibilityChanged());
        },
        expect: () => const <LoginState>[
          LoginState(
            idnumber: IdNumber.dirty(),
            status: FormzStatus.invalid,
          ),
          LoginState(
            idnumber: IdNumber.dirty(),
            status: FormzStatus.invalid,
            password: Password.dirty(),
          ),
          LoginState(
            idnumber: IdNumber.dirty(),
            password: Password.dirty(),
            passwordVisible: true,
            status: FormzStatus.invalid,
          ),
          LoginState(
            idnumber: IdNumber.dirty(),
            password: Password.dirty(),
            passwordVisible: false,
            status: FormzStatus.invalid,
          ),
        ],
      );
    });
  });
}
