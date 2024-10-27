import 'package:flutter/material.dart';
import 'package:todo/constants.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  const MyButton({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: darkPurple,
          borderRadius: BorderRadius.circular(
            resHeight(15, context),
          ),
        ),
        height: resHeight(55, context),
        child: Text(
          title,
          style: TextStyle(
            fontSize: resHeight(20, context),
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
