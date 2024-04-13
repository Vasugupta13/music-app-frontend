import 'package:flutter/material.dart';
import 'package:music_player/src/res/color.dart';

class ReusableButton extends StatelessWidget {
  final String? text;
  final Function()? onPressed;
  final double horizontal;
  final double vertical;
  final double? size;
  final double borderRadius;
  final FontWeight? weight;
  final double? borderWidth;
  final Widget? child;
  const ReusableButton({
    super.key,
    this.borderRadius = 8,
     this.text,
     this.horizontal = 0,
     this.vertical = 0,
    this.onPressed,
    this.size = 16,
    this.weight = FontWeight.w600, this.borderWidth = 2,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
              side:  BorderSide(
                width: borderWidth ?? 2,
                color: AppColors.kPrimaryBackground,
              ),
              borderRadius: BorderRadius.circular(borderRadius)),
          padding:
          EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child ?? Text(text!, style: TextStyle(
              fontWeight: weight,
              fontSize: size,
          ) ),
        ],
      ),
    );
  }
}