import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextformfieldScreen extends StatelessWidget {
  final String hintText;
  final double? hintFontSize;
  final FontWeight hintFontWeight;
  final Color? color;
  final Color? hintTextColor;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? suffixIcon; // Still supported
  final Widget? suffixIconWidget; // NEW - custom widget support (e.g. IconButton)
  final String? suffixImagePath;
  final String? text;
  final String? prefixImagePath;
  final int? maxLines;
  final String? labelText;
  final String? Function(String?)? validator;
  final double borderRadius;

  const TextformfieldScreen({
    super.key,
    this.validator,
    this.labelText,
    required this.hintText,
    required this.hintFontSize,
    required this.hintFontWeight,
    required this.color,
    required this.hintTextColor,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.suffixIconWidget, // NEW PARAMETER
    this.suffixImagePath,
    this.prefixImagePath,
    this.text,
    this.maxLines,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color(0xFFDCDCDC)),
        borderRadius: BorderRadius.circular(borderRadius),
        color: color ?? Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              maxLines: maxLines ?? 1,
              controller: controller,
              obscureText: obscureText,
              validator: validator,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                filled: true,
                fillColor: color ?? Colors.white,
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: hintFontSize,
                  fontWeight: hintFontWeight,
                  color: hintTextColor,
                ),
                suffixIcon: suffixIconWidget ??
                    (suffixIcon != null
                        ? Icon(
                      suffixIcon,
                      size: 35,
                    )
                        : suffixImagePath != null
                        ? Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: Image.asset(
                        suffixImagePath!,
                        height: 24,
                        width: 24,
                      ),
                    )
                        : null),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                prefixIcon: prefixImagePath != null
                    ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    prefixImagePath!,
                    height: 20,
                    width: 20,
                  ),
                )
                    : null,
              ),
            ),
          ),
          if (text != null)
            Text(
              text!,
              style: TextStyle(
                color: const Color(0xFF000000),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
    );
  }
}
