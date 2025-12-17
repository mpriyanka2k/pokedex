import 'package:flutter/material.dart';

class CustomTextStyle {
 

  static Widget bold({
    String? text,
    double? fontSize,
    Color? color,
    bool? softWrap,
    int? maxLines,
    TextAlign? textAlign,
    FontWeight? fontWeight
  }) {
    return Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color,
      ),
      softWrap: softWrap ?? false,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }


   static Widget extraBold({
    String? text, 
    double? fontSize, 
    Color? color,
    bool? softWrap,
    int? maxLine,
    TextAlign? textAlign,
    FontWeight? fontWeight}) {
    return Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w800,
        color: color,
      ),
      maxLines: maxLine ?? 2,
      overflow: TextOverflow.ellipsis,
    );
  }


  static Widget semiBold(
      {String? text,
      double? fontSize,
      Color? color,
      int? maxLines,
      TextAlign? textAlign,
      FontWeight? fontWeight,
      bool? softWrap}) {
    return Text(
      text!,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color,
      ),
      softWrap: softWrap ?? false,
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  static Widget regular(
      {
         String? text,
    double? fontSize,
    Color? color,
    bool? softWrap,
    int? maxLines,
    TextAlign? textAlign,
    FontWeight? fontWeight
        }) {
    return Text(
      text!,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color,
      ),
      maxLines: maxLines,
      softWrap: softWrap ?? true,
      overflow: TextOverflow.ellipsis,
    );
  }

}