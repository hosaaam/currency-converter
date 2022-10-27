import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CustomText({
required String? text,
  int? fontSize = 25,
}) => Text(text!, style: const TextStyle( fontSize: 25));
