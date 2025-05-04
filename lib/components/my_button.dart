import 'package:flutter/material.dart';
import 'package:rentyne/resources/color_manager.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color:ColorManager.secondary,
        ),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        )),
      ),
    );
  }
}
