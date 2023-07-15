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

class User {
  final String fullName;
  final String idNumber;
  final String email;
  final String mobileNumber;
  final String password;
  final String confirmPassword;
  final bool checkbox;
  final int otpPreference;

  User({
    required this.fullName,
    required this.idNumber,
    required this.password,
    required this.confirmPassword,
    required this.mobileNumber,
    required this.checkbox,
    this.email = "",
    this.otpPreference = 1,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': fullName,
      'identificationNumber': idNumber,
      'email': email,
      'mobileNumber': mobileNumber,
      'password': password,
      'otpPreference': otpPreference,
    };
  }
}
