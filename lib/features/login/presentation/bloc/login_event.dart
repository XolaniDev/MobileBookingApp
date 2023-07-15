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

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginIdentificationNumberChanged extends LoginEvent {
  final String idnumber;
  const LoginIdentificationNumberChanged(this.idnumber);

  @override
  List<Object> get props => [idnumber];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  const LoginPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class LoginIdNumberUnfocused extends LoginEvent {}

class LoginPasswordUnfocused extends LoginEvent {}

class LoginPasswordVisibilityChanged extends LoginEvent {}
class  LoginSubmitted extends LoginEvent{
  const LoginSubmitted();
}

