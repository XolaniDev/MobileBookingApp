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

import 'package:flutter/material.dart';

class MyMaterialTextFormField extends Material {
  MyMaterialTextFormField({
    Key? key,
    labelText,
    String? initialValue,
    FocusNode? focusNode,
    keyboardType,
    onChanged,
    textInputAction,
    obscureText = false,
    String? helperText,
    int? helperMaxLines,
    int? errorMaxLines,
    String? errorText,
    Widget? suffixIcon,
  }) : super(
          key: key,
          elevation: 0,
          shadowColor: Colors.grey.shade200,
          color: Colors.transparent,
          child: TextFormField(
            initialValue: initialValue,
            focusNode: focusNode,
            obscureText: obscureText,
            decoration: InputDecoration(
              labelText: labelText,
              errorText: errorText,
              helperText: helperText,
              helperMaxLines: helperMaxLines,
              errorMaxLines: errorMaxLines,
              filled: true,
              fillColor: Colors.white,
              labelStyle: const TextStyle(
                color: Color(0xff27b88d),
              ),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  borderSide: BorderSide.none),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              suffixIcon: suffixIcon,
            ),
            keyboardType: keyboardType,
            onChanged: onChanged,
            textInputAction: textInputAction,
          ),
        );
}