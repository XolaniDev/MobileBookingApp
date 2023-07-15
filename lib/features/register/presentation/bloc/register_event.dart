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

part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterFullNameChanged extends RegisterEvent {
  final String fullName;
  const RegisterFullNameChanged(this.fullName);

  @override
  List<Object> get props => [fullName];
}

class RegisterIdentificationNumberChanged extends RegisterEvent {
  final String idNumber;
  const RegisterIdentificationNumberChanged(this.idNumber);

  @override
  List<Object> get props => [idNumber];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;
  const RegisterEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class RegisterMobileNumberChanged extends RegisterEvent {
  final String mobileNumber;
  const RegisterMobileNumberChanged(this.mobileNumber);

  @override
  List<Object> get props => [mobileNumber];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  const RegisterPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class RegisterConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;
  const RegisterConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

class RegisterCheckboxChecked extends RegisterEvent {
  final bool checkbox;
  const RegisterCheckboxChecked(this.checkbox);

  @override
  List<Object> get props => [checkbox];
}

class RegisterFullNameUnfocused extends RegisterEvent {}

class RegisterIdNumberUnfocused extends RegisterEvent {}

class RegisterMobileNumberUnfocused extends RegisterEvent {}

class RegisterEmailUnfocused extends RegisterEvent {}

class RegisterPasswordUnfocused extends RegisterEvent {}

class RegisterConfirmPasswordUnfocused extends RegisterEvent {}

class RegisterPasswordVisibilityChanged extends RegisterEvent {}

class RegisterConfirmPasswordVisibilityChanged extends RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}
