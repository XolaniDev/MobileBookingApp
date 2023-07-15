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

import 'package:bloc/bloc.dart';
import 'package:dcvc_flutter/core/services/repository.dart';
import 'package:dcvc_flutter/features/login/data/login.dart';
import 'package:dcvc_flutter/features/login/domain/models/idnumber.dart';
import 'package:dcvc_flutter/features/login/domain/models/password.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Repository _repository;

  LoginBloc({
    required Repository repository,
  })  : _repository = repository,
        super(const LoginState()) {
    on<LoginIdentificationNumberChanged>(_onIdNumberChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginPasswordVisibilityChanged>(_onPasswordVisibilityChanged);
    on<LoginIdNumberUnfocused>(_onIdNumberUnfocused);
    on<LoginPasswordUnfocused>(_onPasswordUnfocused);
  }
  void _onIdNumberChanged(
    LoginIdentificationNumberChanged event,
    Emitter<LoginState> emit,
  ) {
    final idnumber = IdNumber.dirty(event.idnumber);
    emit(state.copyWith(
      idnumber: idnumber,
      status: Formz.validate([
        idnumber,
        state.password
      ]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        password,
        state.idnumber
      ]),
    ));
  }

  void _onIdNumberUnfocused(
    LoginIdNumberUnfocused event,
    Emitter<LoginState> emit,
  ) {
    final idnumber = IdNumber.dirty(state.idnumber.value);
    emit(state.copyWith(
      idnumber: idnumber,
      status: Formz.validate([
        idnumber,
        state.password
      ]),
    ));
  }

  void _onPasswordUnfocused(
    LoginPasswordUnfocused event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        password,
        state.idnumber
      ]),
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {

    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        var result = await _repository.loginUser(Login(
          idNumber: state.idnumber.value,
          password: state.password.value,
        ));
       
        if (!result[0]) 
        {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        } else {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        }
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  void _onPasswordVisibilityChanged(
    LoginPasswordVisibilityChanged event,
    Emitter<LoginState> emit,
  ) {
    final visibility = !state.passwordVisible;
    emit(state.copyWith(
      passwordVisible: visibility,
      status: Formz.validate([
        state.idnumber,
        state.password
      ]),
    ));
  }
}
