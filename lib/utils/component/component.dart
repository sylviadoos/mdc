import 'package:flutter/material.dart';

Widget customText(String txt,
    {TextAlign textAlign = TextAlign.start,
    AlignmentGeometry alignment = Alignment.topLeft,
    double fontSize = 18,
    int maxLine = 2,
    FontWeight fontWeight = FontWeight.normal,
    String fontFamily = 'Airbnb',
    Color? color = Colors.black}) {
  return Container(
    alignment: alignment,
    child: Text(
      txt,
      maxLines: 2,
      style: TextStyle(
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: color),
      textAlign: textAlign,
    ),
  );
}

Widget defaultFormField(
        {required TextEditingController? controller,
        required TextInputType? type,
        void Function(String? s)? onSubmit,
        void Function(String? s)? onChange,
        void Function()? onTap,
        double? writeFontSize,
        bool isPassword = false,
        FontWeight? fontWeight,
        String? Function(String? s)? validate,
        String? label,
        bool autofocus = false,
        Widget? prefix,
        double? cursorHeight = 20,
        Widget? suffix,
        TextAlign textAlign = TextAlign.start,
        TextAlignVertical? textAlignVertical = TextAlignVertical.center,
        void Function()? suffixPressed,
        bool isClickable = true,
        double focusBorderRadius = 8,
        double labelFontSize = 8,
        Color focusColor = Colors.grey,
        Key? key,
        Color? fillColor,
        Color? labelColor = const Color(0xff707070),
        void Function(String?)? onSaved,
        Color borderColor = Colors.grey,
        double borderRadius = 8,
        Color? writeTextColor,
        FocusNode? focusNode,
        void Function()? onEditingComplete,
        TextInputAction? textInputAction,
        void Function()? prefixPressed,
        int? minLines = 1,
        int? maxLines,
        double borderWidth = 1.0,
        EdgeInsetsGeometry? contentPadding = const EdgeInsets.all(8),
        String? prefixText,
        TextStyle? hintStyle,
        Color? prefixIconColor,
        Color? cursorColor,
        Color? suffixIconColor,
        Color disableColor = const Color(0xFF000000),
        double disableBorderwidth = 1.0,
        double disableBorderRadius = 12,
        double cursorWidth = 2.0,
        bool enable = false,
        String? hintText}) =>
    TextFormField(
      autofocus: autofocus,
      textAlignVertical: textAlignVertical,
      minLines: minLines,
      maxLines: maxLines,
      textAlign: textAlign,
      cursorHeight: cursorHeight,
      textInputAction: textInputAction,
      focusNode: focusNode,
      style: TextStyle(
          color: writeTextColor,
          fontSize: writeFontSize,
          fontWeight: fontWeight),
      key: key,
      onEditingComplete: onEditingComplete,
      onSaved: onSaved,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      cursorColor: cursorColor,
      cursorWidth: cursorWidth,
      decoration: InputDecoration(
        enabled: enable,
        disabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: disableColor, width: disableBorderwidth),
            borderRadius: BorderRadius.circular(disableBorderRadius)),
        contentPadding: contentPadding,
        prefixText: prefixText,
        filled: fillColor == null ? false : true,
        fillColor: fillColor, focusColor: focusColor,
        hintText: hintText,
        hintStyle: hintStyle, prefixIconColor: prefixIconColor,
        suffixIconColor: suffixIconColor,
        // helperText: hintText, //go hiny up to field
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(borderRadius)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusColor),
            borderRadius: BorderRadius.circular(focusBorderRadius)),
        labelText: label,
        labelStyle: TextStyle(fontSize: labelFontSize, color: labelColor),
        prefixIcon: prefix != null
            ? InkWell(onTap: prefixPressed, child: prefix)
            : null,
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: suffix,
              )
            : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(focusBorderRadius))),
      ),
    );
