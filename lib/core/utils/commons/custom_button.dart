import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color textColor;
  final Color backgroundColor;
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isLoading;


  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.horizontalPadding = 100,
    this.verticalPadding = 15,
    this.borderRadius = 10,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
    this.isLoading = false
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding.w,
          vertical: verticalPadding.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
      ),
      child: 
      isLoading ? SizedBox(
        height: fontSize.sp,
        width: fontSize.sp,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
          strokeWidth: 2.0,
        ),
      ):
      Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize.sp,
          fontWeight: fontWeight,
        ),
      ),


    );
  }
}
