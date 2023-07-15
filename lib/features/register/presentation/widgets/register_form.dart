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

import '/features/login/presentation/pages/login_page.dart';
import '/features/register/presentation/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'my_material_text_form_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _fullnameFocusNode = FocusNode();
  final _idnumberFocusNode = FocusNode();
  final _mobilenumberFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmpasswordFocusNode = FocusNode();
  final _checkboxFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _fullnameFocusNode.addListener(() {
      if (!_fullnameFocusNode.hasFocus) {
        context.read<RegisterBloc>().add(RegisterFullNameUnfocused());
      }
    });
    _idnumberFocusNode.addListener(() {
      if (!_idnumberFocusNode.hasFocus) {
        context.read<RegisterBloc>().add(RegisterIdNumberUnfocused());
      }
    });
    _mobilenumberFocusNode.addListener(() {
      if (!_mobilenumberFocusNode.hasFocus) {
        context.read<RegisterBloc>().add(RegisterMobileNumberUnfocused());
      }
    });
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<RegisterBloc>().add(RegisterEmailUnfocused());
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<RegisterBloc>().add(RegisterPasswordUnfocused());
      }
    });
    _confirmpasswordFocusNode.addListener(() {
      if (!_confirmpasswordFocusNode.hasFocus) {
        context.read<RegisterBloc>().add(RegisterConfirmPasswordUnfocused());
      }
    });
    _checkboxFocusNode.addListener(() {
      if (!_checkboxFocusNode.hasFocus) {
        context.read<RegisterBloc>().add(const RegisterCheckboxChecked(false));
      }
    });
  }

  @override
  void dispose() {
    _fullnameFocusNode.dispose();
    _idnumberFocusNode.dispose();
    _mobilenumberFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _confirmpasswordFocusNode.dispose();
    _checkboxFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Row(children: const <Widget>[
                    Icon(
                      Icons.check_circle_outline_rounded,
                      color: Color(0xff27b88d),
                    ),
                    Text(' Successfully Registered',
                        style: TextStyle(color: Color(0xff27b88d)))
                  ]),
                  backgroundColor: Colors.white,
                  behavior: SnackBarBehavior.floating,
                  elevation: 5,
                  margin: const EdgeInsets.all(5),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
            );
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const LoginPage()));
          });
        }
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Row(children: const <Widget>[
                    Icon(
                      Icons.cancel_outlined,
                      color: Colors.red,
                    ),
                    Text(' Unsuccessfully Registered',
                        style: TextStyle(color: Colors.red))
                  ]),
                  backgroundColor: Colors.white,
                  behavior: SnackBarBehavior.floating,
                  elevation: 5,
                  margin: const EdgeInsets.all(5),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
            );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FullNameInput(focusNode: _fullnameFocusNode),
          const SizedBox(height: 16),
          IdNumberInput(focusNode: _idnumberFocusNode),
          const SizedBox(height: 16),
          EmailInput(focusNode: _emailFocusNode),
          const SizedBox(height: 16),
          MobileNumberInput(focusNode: _mobilenumberFocusNode),
          const SizedBox(height: 16),
          PasswordInput(focusNode: _passwordFocusNode),
          const SizedBox(height: 16),
          ConfirmPasswordInput(focusNode: _confirmpasswordFocusNode),
        ],
      ),
    );
  }
}

class FullNameInput extends StatelessWidget {
  final FocusNode focusNode;

  const FullNameInput({Key? key, required this.focusNode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return MyMaterialTextFormField(
        key: const Key('FullName_TextField'),
        initialValue: state.fullname.value,
        focusNode: focusNode,
        labelcolor:
            state.fullname.invalid ? Colors.red : const Color(0xff27b88d),
        labelText: 'Full name *',
        errorTextStyle: const TextStyle(height: 0, fontSize: 0.1),
        errorText: state.fullname.invalid ? '' : null,
        onChanged: (value) {
          context.read<RegisterBloc>().add(RegisterFullNameChanged(value));
        },
      );
    });
  }
}

class IdNumberInput extends StatelessWidget {
  final FocusNode focusNode;

  const IdNumberInput({Key? key, required this.focusNode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return MyMaterialTextFormField(
        key: const Key('ID_TextField'),
        labelcolor: state.idnumber.invalid
            ? Colors.red
            : (state.idexists == true)
                ? Colors.red
                : const Color(0xff27b88d),
        labelText: 'ID number *',
        errorTextStyle: state.idnumber.invalid
            ? const TextStyle(height: 0, fontSize: 0.1)
            : (state.idexists == true)
                ? const TextStyle(height: 0, fontSize: 12)
                : null,
        errorText: state.idnumber.invalid
            ? ''
            : (state.idexists == true)
                ? 'ID already Exists'
                : null,
        initialValue: state.idnumber.value,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          context
              .read<RegisterBloc>()
              .add(RegisterIdentificationNumberChanged(value));
        },
      );
    });
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return MyMaterialTextFormField(
        key: const Key('Email_TextField'),
        labelText: 'Email address',
        labelcolor: state.email.invalid ? Colors.red : const Color(0xff27b88d),
        errorTextStyle: const TextStyle(height: 0, fontSize: 0.1),
        errorText: state.email.invalid ? '' : null,
        initialValue: state.email.value,
        focusNode: focusNode,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          context.read<RegisterBloc>().add(RegisterEmailChanged(value));
        },
      );
    });
  }
}

class MobileNumberInput extends StatelessWidget {
  const MobileNumberInput({Key? key, required this.focusNode})
      : super(key: key);
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return MyMaterialTextFormField(
        key: const Key('MobileNumber_TextField'),
        labelText: 'Mobile number *',
        labelcolor:
            state.mobilenumber.invalid ? Colors.red : const Color(0xff27b88d),
        errorTextStyle: const TextStyle(height: 0, fontSize: 0.1),
        errorText: state.mobilenumber.invalid ? '' : null,
        initialValue: state.mobilenumber.value,
        focusNode: focusNode,
        keyboardType: TextInputType.phone,
        onChanged: (value) {
          context.read<RegisterBloc>().add(RegisterMobileNumberChanged(value));
        },
      );
    });
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        var visible = state.passwordVisible;

        return MyMaterialTextFormField(
          key: const Key('Password_TextField'),
          initialValue: state.password.value,
          focusNode: focusNode,
          labelText: 'Password *',
          labelcolor:
              state.password.invalid ? Colors.red : const Color(0xff27b88d),
          errorTextStyle: const TextStyle(height: 0, fontSize: 12),
          errorText: state.password.invalid ? 'Incorrect Entry' : null,
          obscureText: !visible,
          onChanged: (value) {
            context.read<RegisterBloc>().add(RegisterPasswordChanged(value));
          },
          suffixIcon: IconButton(
            onPressed: () => context
                .read<RegisterBloc>()
                .add(RegisterPasswordVisibilityChanged()),
            icon: Icon(
              visible ? Icons.visibility : Icons.visibility_off,
              key: const Key("Icon1"),
            ),
          ),
        );
      },
    );
  }
}

class ConfirmPasswordInput extends StatelessWidget {
  const ConfirmPasswordInput({Key? key, required this.focusNode})
      : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        var visible = state.confirmPasswordVisible;

        return MyMaterialTextFormField(
          key: const Key('ConfirmPassword_TextField'),
          initialValue: state.confirmpassword.value,
          labelcolor: state.confirmpassword.invalid
              ? Colors.red
              : (state.confirmpassword.value != state.password.value)
                  ? Colors.red
                  : const Color(0xff27b88d),
          focusNode: focusNode,
          labelText: 'Confirm Password *',
          errorTextStyle: const TextStyle(height: 0, fontSize: 12),
          errorText: (state.confirmpassword.value != state.password.value)
              ? 'Passwords do not match.'
              : null,
          obscureText: !visible,
          onChanged: (value) {
            context
                .read<RegisterBloc>()
                .add(RegisterConfirmPasswordChanged(value));
          },
          suffixIcon: IconButton(
            onPressed: () => context
                .read<RegisterBloc>()
                .add(RegisterConfirmPasswordVisibilityChanged()),
            icon: Icon(
              visible ? Icons.visibility : Icons.visibility_off,
              key: const Key("Icon2"),
            ),
          ),
        );
      },
    );
  }
}
