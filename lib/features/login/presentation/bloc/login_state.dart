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

part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final IdNumber idnumber;
  final Password password;
  final bool passwordVisible;
 

  const LoginState({
    this.status = FormzStatus.pure,
    this.idnumber = const IdNumber.pure(),
    this.password = const Password.pure(),
    this.passwordVisible = false,

  });

  LoginState copyWith({
    FormzStatus? status,
    IdNumber? idnumber,
    Password? password,
    bool? passwordVisible,

  }) {
    return LoginState(
      status: status ?? this.status,
      idnumber: idnumber ?? this.idnumber,
      password: password ?? this.password,
      passwordVisible: passwordVisible ?? this.passwordVisible,
    );
  }

  @override
  List<Object?> get props => [
        status,
        idnumber,
        password,
        passwordVisible,

      ];
}
