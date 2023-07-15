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

import '/features/register/presentation/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '/features/terms_and_conditions/terms_and_conditions.dart';
import 'package:flutter/gestures.dart';

class BottomSheetCard extends StatefulWidget {
  const BottomSheetCard({Key? key}) : super(key: key);

  @override
  State<BottomSheetCard> createState() => _BottomSheetCard();
}

class _BottomSheetCard extends State<BottomSheetCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: double.infinity,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        borderOnForeground: true,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 0.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return Wrap(children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: FractionallySizedBox(
                              widthFactor: 1,
                              child: ElevatedButton(
                                onPressed: state.status.isValidated
                                    ? () => context
                                        .read<RegisterBloc>()
                                        .add(const RegisterSubmitted())
                                    : null,
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Color(0xfff8f8f8),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0),
                                ),
                                style: ButtonStyle(
                                    elevation:
                                        MaterialStateProperty.all<double>(5),
                                    shadowColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return const Color(0xff27b88d);
                                        } else if (states
                                            .contains(MaterialState.disabled)) {
                                          return Colors.grey;
                                        }
                                        return const Color(0xff27b88d);
                                      },
                                    ),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                    )),
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(
                                            const Size(10, 46))),
                              ))),
                      const Text(""),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  key: const Key('T&C_link'),
                                  text: TextSpan(
                                      text: "T & C's",
                                      style:
                                          const TextStyle(color: Colors.grey),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TermsAndConditionsScreen()),
                                          );
                                        }),
                                ),
                                Checkbox(
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                      context
                                        ..read<RegisterBloc>().add(
                                            RegisterCheckboxChecked(isChecked));
                                    })
                              ]))
                    ])
              ]);
            },
          ),
        ),
      ),
    );
  }
}
