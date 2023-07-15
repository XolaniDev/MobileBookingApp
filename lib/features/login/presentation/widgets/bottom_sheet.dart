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

import 'package:dcvc_flutter/features/login/presentation/bloc/login_bloc.dart';
import 'package:dcvc_flutter/features/register/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hexcolor/hexcolor.dart';

class BottomSheetCard extends StatefulWidget {
  const BottomSheetCard({Key? key}) : super(key: key);

  @override
  State<BottomSheetCard> createState() => _BottomSheetCard();
}

class _BottomSheetCard extends State<BottomSheetCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: double.infinity,
      height: 120,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 0.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: ButtonTheme(
                        height: 46,
                        child: ElevatedButton(
                          onPressed: state.status.isValidated
                              ? () {
                                  context
                                      .read<LoginBloc>()
                                      .add(const LoginSubmitted());
                                }
                              : null,
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xfff8f8f8),
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                          style: ButtonStyle(
                            shadowColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.black;
                                } else if (states
                                    .contains(MaterialState.disabled)) {
                                  return Colors.black;
                                }
                                return Colors.black;
                              },
                            ),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return const Color(0xff27b88d);
                                } else if (states
                                    .contains(MaterialState.disabled)) {
                                  return const Color(0xFFD6D6D6);
                                }
                                return HexColor("27B88D");
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            )),
                            minimumSize: MaterialStateProperty.all<Size>(
                              const Size(10, 46),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Color(0xff6D6A6A)),
                      ),
                      RichText(
                        key: const Key('Top'),
                        text: TextSpan(
                          text: ' Register',
                          style: const TextStyle(
                            color: Color(0xff27b88d),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                        ),
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}