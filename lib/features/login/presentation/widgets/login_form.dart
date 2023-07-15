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

import 'package:dcvc_flutter/core/bloc/authentication/auth_bloc.dart';
import 'package:dcvc_flutter/features/home_page/presentation/pages/home_page.dart';
import 'package:dcvc_flutter/features/login/presentation/bloc/login_bloc.dart';
import 'package:dcvc_flutter/features/login/presentation/widgets/my_material_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _idnumberFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _idnumberFocusNode.addListener(() {
      if (!_idnumberFocusNode.hasFocus) {
        context.read<LoginBloc>().add(LoginIdNumberUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<LoginBloc>().add(LoginPasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _idnumberFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
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
                  Text(
                    'Successful Login.',
                    style: TextStyle(
                      color: Color(0xff27b88d),
                    ),
                  )
                ]),
                backgroundColor: Colors.white,
                behavior: SnackBarBehavior.floating,
                elevation: 5,
                margin: const EdgeInsets.all(5),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            );
          context.read<AuthBloc>().add(AuthLogIn());
          Future.delayed(
            const Duration(seconds: 3),
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomePage(),
                ),
              );
            },
          );
        }
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(children: const <Widget>[
                  Icon(
                    Icons.cancel_outlined,
                    color: Color.fromRGBO(218, 67, 54, 0.5),
                  ),
                  Text(
                    'Unsuccessful Login',
                    style: TextStyle(color: Colors.red),
                  )
                ]),
                backgroundColor: Colors.white,
                behavior: SnackBarBehavior.floating,
                elevation: 5,
                margin: const EdgeInsets.all(5),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IdNumberInput(focusNode: _idnumberFocusNode),
          const SizedBox(
            height: 16,
          ),
          PasswordInput(focusNode: _passwordFocusNode),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class IdNumberInput extends StatelessWidget {
  final FocusNode focusNode;

  const IdNumberInput({Key? key, required this.focusNode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return MyMaterialTextFormField(
        key: const Key('ID_TextField'),
        labelText: 'ID number *',
        errorText: state.idnumber.invalid ? '' : null,
        initialValue: state.idnumber.value,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          context
              .read<LoginBloc>()
              .add(LoginIdentificationNumberChanged(value));
        },
        textInputAction: TextInputAction.next,
      );
    });
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        var visible = state.passwordVisible;

        return MyMaterialTextFormField(
          initialValue: state.password.value,
          focusNode: focusNode,
          key: const Key('Password_TextField'),
          labelText: 'Password *',
          errorText: state.password.invalid ? 'Incorrect entry' : null,
          obscureText: !visible,
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginPasswordChanged(value));
          },
          textInputAction: TextInputAction.done,
          suffixIcon: IconButton(
            onPressed: () =>
                context.read<LoginBloc>().add(LoginPasswordVisibilityChanged()),
            icon: Icon(
              visible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
