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
import '/features/register/data/user.dart';
import '/features/register/domain/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final Repository _repository;

  RegisterBloc({
    required Repository repository,
  })  : _repository = repository,
        super(const RegisterState()) {
    on<RegisterFullNameChanged>(_onFullNameChanged);
    on<RegisterIdentificationNumberChanged>(_onIdNumberChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterMobileNumberChanged>(_onMobileNumberChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterSubmitted>(_onSubmitted);
    on<RegisterPasswordVisibilityChanged>(_onPasswordVisibilityChanged);
    on<RegisterConfirmPasswordVisibilityChanged>(
        _onConfirmPasswordVisibilityChanged);
    on<RegisterFullNameUnfocused>(_onFullNameUnfocused);
    on<RegisterIdNumberUnfocused>(_onIdNumberUnfocused);
    on<RegisterEmailUnfocused>(_onEmailUnfocused);
    on<RegisterMobileNumberUnfocused>(_onMobileNumberUnfocused);
    on<RegisterPasswordUnfocused>(_onPasswordUnfocused);
    on<RegisterConfirmPasswordUnfocused>(_onConfirmPasswordUnfocused);
    on<RegisterCheckboxChecked>(_onCheckboxChecked);
  }

  void _onFullNameChanged(
    RegisterFullNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final fullname = Fullname.dirty(event.fullName);
    emit(state.copyWith(
      fullname: fullname,
      status: Formz.validate([
        fullname,
        state.idnumber,
        state.email,
        state.mobilenumber,
        state.password,
        state.confirmpassword,
        state.checkbox,
      ]),
    ));
  }

  void _onIdNumberChanged(
    RegisterIdentificationNumberChanged event,
    Emitter<RegisterState> emit,
  ) {
    final idnumber = IdNumber.dirty(event.idNumber);
    emit(state.copyWith(
      idnumber: idnumber,
      idexists: false,
      status: Formz.validate([
        state.fullname,
        idnumber,
        state.email,
        state.mobilenumber,
        state.password,
        state.confirmpassword,
        state.checkbox,
      ]),
    ));
  }

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        state.fullname,
        state.idnumber,
        email,
        state.mobilenumber,
        state.password,
        state.confirmpassword,
        state.checkbox,
      ]),
    ));
  }

  void _onMobileNumberChanged(
    RegisterMobileNumberChanged event,
    Emitter<RegisterState> emit,
  ) {
    final mobilenumber = MobileNumber.dirty(event.mobileNumber);
    emit(state.copyWith(
      mobilenumber: mobilenumber,
      status: Formz.validate([
        state.fullname,
        state.idnumber,
        state.email,
        mobilenumber,
        state.password,
        state.confirmpassword,
        state.checkbox,
      ]),
    ));
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.fullname,
        state.idnumber,
        state.email,
        state.mobilenumber,
        password,
        state.confirmpassword,
        state.checkbox,
      ]),
    ));
  }

  void _onConfirmPasswordChanged(
    RegisterConfirmPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final confirmpassword = ConfirmPassword.dirty(event.confirmPassword);
    emit(state.copyWith(
      confirmpassword: confirmpassword,
      status: Formz.validate([
        state.fullname,
        state.idnumber,
        state.email,
        state.mobilenumber,
        state.password,
        confirmpassword,
        state.checkbox,
      ]),
    ));
  }

  void _onCheckboxChecked(
    RegisterCheckboxChecked event,
    Emitter<RegisterState> emit,
  ) {
    final checkbox = Checkbox.dirty(event.checkbox);
    emit(state.copyWith(
      checkbox: checkbox,
      status: Formz.validate([
        state.fullname,
        state.idnumber,
        state.email,
        state.mobilenumber,
        state.password,
        state.confirmpassword,
        checkbox,
      ]),
    ));
  }

  void _onFullNameUnfocused(
    RegisterFullNameUnfocused event,
    Emitter<RegisterState> emit,
  ) {
    final fullname = Fullname.dirty(state.fullname.value);
    emit(state.copyWith(
      fullname: fullname,
      status: Formz.validate([
        fullname,
        state.idnumber,
        state.email,
        state.mobilenumber,
        state.password,
        state.confirmpassword,
        state.checkbox,
      ]),
    ));
  }

  void _onIdNumberUnfocused(
    RegisterIdNumberUnfocused event,
    Emitter<RegisterState> emit,
  ) {
    final idnumber = IdNumber.dirty(state.idnumber.value);
    emit(state.copyWith(
      idnumber: idnumber,
      status: Formz.validate([
        state.fullname,
        idnumber,
        state.email,
        state.mobilenumber,
        state.password,
        state.confirmpassword,
        state.checkbox,
      ]),
    ));
  }

  void _onEmailUnfocused(
      RegisterEmailUnfocused event, Emitter<RegisterState> emit) {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        state.fullname,
        state.idnumber,
        email,
        state.mobilenumber,
        state.password,
        state.confirmpassword,
        state.checkbox,
      ]),
    ));
  }

  void _onMobileNumberUnfocused(
    RegisterMobileNumberUnfocused event,
    Emitter<RegisterState> emit,
  ) {
    final mobilenumber = MobileNumber.dirty(state.mobilenumber.value);
    emit(state.copyWith(
      mobilenumber: mobilenumber,
      status: Formz.validate([
        state.fullname,
        state.idnumber,
        state.email,
        mobilenumber,
        state.password,
        state.confirmpassword,
        state.checkbox,
      ]),
    ));
  }

  void _onPasswordUnfocused(
    RegisterPasswordUnfocused event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.fullname,
        state.idnumber,
        state.email,
        state.mobilenumber,
        password,
        state.confirmpassword,
        state.checkbox,
      ]),
    ));
  }

  void _onConfirmPasswordUnfocused(
    RegisterConfirmPasswordUnfocused event,
    Emitter<RegisterState> emit,
  ) {
    final confirmpassword = ConfirmPassword.dirty(state.confirmpassword.value);
    emit(state.copyWith(
      confirmpassword: confirmpassword,
      status: Formz.validate([
        state.fullname,
        state.idnumber,
        state.email,
        state.mobilenumber,
        state.password,
        confirmpassword,
        state.checkbox,
      ]),
    ));
  }

  String mobileNumberConverter(String inputMobileNumber) {
    List<String> stringArray = [];
    for (var i = 0; i < inputMobileNumber.length; i++) {
      if (int.tryParse(inputMobileNumber[i]) != null) {
        stringArray.add(inputMobileNumber[i]);
      }
    }
    if (stringArray.length > 10) {
      stringArray.removeAt(0);
      stringArray.removeAt(0);
    }
    String outputMobileNumber = '(' +
        stringArray[0] +
        stringArray[1] +
        stringArray[2] +
        ')-' +
        stringArray[3] +
        stringArray[4] +
        stringArray[5] +
        '-' +
        stringArray[6] +
        stringArray[7] +
        stringArray[8] +
        stringArray[9];
    return outputMobileNumber;
  }

  void _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        var result = await _repository.registerUser(User(
          fullName: state.fullname.value,
          idNumber: state.idnumber.value,
          email: state.email.value,
          mobileNumber: mobileNumberConverter(state.mobilenumber.value),
          password: state.password.value,
          confirmPassword: state.confirmpassword.value,
          checkbox: state.checkbox.value,
        ));
        if (!result[0] ||
            (state.confirmpassword.value != state.password.value)) {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
          if (result[1] == "ID already exists.") {
            emit(state.copyWith(idexists: true));
          }
        } else {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        }
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  void _onPasswordVisibilityChanged(
    RegisterPasswordVisibilityChanged event,
    Emitter<RegisterState> emit,
  ) {
    final visibility = !state.passwordVisible;
    emit(state.copyWith(
      passwordVisible: visibility,
      status: Formz.validate([
        state.fullname,
        state.idnumber,
        state.email,
        state.mobilenumber,
        state.password,
        state.confirmpassword,
        state.checkbox,
      ]),
    ));
  }

  void _onConfirmPasswordVisibilityChanged(
    RegisterConfirmPasswordVisibilityChanged event,
    Emitter<RegisterState> emit,
  ) {
    final visibility = !state.confirmPasswordVisible;
    emit(state.copyWith(
      confirmPasswordVisible: visibility,
      status: Formz.validate([
        state.fullname,
        state.idnumber,
        state.email,
        state.mobilenumber,
        state.password,
        state.confirmpassword,
        state.checkbox,
      ]),
    ));
  }
}
