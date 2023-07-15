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

class RegisterState extends Equatable {
  final FormzStatus status;
  final Fullname fullname;
  final IdNumber idnumber;
  final Email email;
  final MobileNumber mobilenumber;
  final Password password;
  final ConfirmPassword confirmpassword;
  final Checkbox checkbox;
  final bool passwordVisible;
  final bool confirmPasswordVisible;
  final bool idexists;

  const RegisterState({
    this.status = FormzStatus.pure,
    this.fullname = const Fullname.pure(),
    this.idnumber = const IdNumber.pure(),
    this.email = const Email.pure(),
    this.mobilenumber = const MobileNumber.pure(),
    this.password = const Password.pure(),
    this.confirmpassword = const ConfirmPassword.pure(),
    this.checkbox = const Checkbox.pure(),
    this.passwordVisible = false,
    this.confirmPasswordVisible = false,
    this.idexists = false,
  });

  RegisterState copyWith({
    FormzStatus? status,
    Fullname? fullname,
    IdNumber? idnumber,
    Email? email,
    MobileNumber? mobilenumber,
    Password? password,
    ConfirmPassword? confirmpassword,
    Checkbox? checkbox,
    bool? passwordVisible,
    bool? confirmPasswordVisible,
    bool? idexists,
  }) {
    return RegisterState(
      status: status ?? this.status,
      fullname: fullname ?? this.fullname,
      idnumber: idnumber ?? this.idnumber,
      email: email ?? this.email,
      mobilenumber: mobilenumber ?? this.mobilenumber,
      password: password ?? this.password,
      confirmpassword: confirmpassword ?? this.confirmpassword,
      checkbox: checkbox ?? this.checkbox,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      confirmPasswordVisible:
          confirmPasswordVisible ?? this.confirmPasswordVisible,
      idexists: idexists ?? this.idexists,
    );
  }

  @override
  List<Object?> get props => [
        status,
        fullname,
        idnumber,
        email,
        mobilenumber,
        password,
        confirmpassword,
        checkbox,
        passwordVisible,
        confirmPasswordVisible,
        idexists,
      ];
}
