import 'package:flutter/material.dart';

const Color lightPurpleScaffoldColor = Color(0xFFD6D7EF);
const Color lightPurple = Color(0xFFB3B7EE);
const Color darkPurple = Color(0xFF9395D3);

double resWidth(int width, BuildContext context) {
  return MediaQuery.of(context).size.width * (width / 375);
}

double resHeight(int height, BuildContext context) {
  return MediaQuery.of(context).size.height * (height / 812);
}
