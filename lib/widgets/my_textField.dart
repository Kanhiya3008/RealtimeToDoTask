import 'package:flutter/material.dart';
import 'package:todoassignment/theme/app_text_style.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? prefixImage;
  final String? suffixImage;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final VoidCallback? onTap;
  final bool isEditable;
  final ValueChanged<String>? onChanged;
  final Color borderColor;
  final Color fillColor;
  final double borderRadius;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.prefixImage,
    this.suffixImage,
    this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.isEditable = true,
    this.onChanged,
    this.borderColor = Colors.blue,
    this.fillColor = Colors.white,
    this.borderRadius = 8.0,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !isEditable && onTap != null ? onTap : null,
      child: AbsorbPointer(
        absorbing: !isEditable,
        child: TextFormField(
          style: AppTextStyles.textFieldStyle,
          controller: controller,
          obscureText: isPassword,
          validator: validator,
          keyboardType: keyboardType,
          onChanged: onChanged,

          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.textFieldHintStyle,
            prefixIcon:
                prefixImage != null
                    ? Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image.asset(prefixImage!, height: 15),
                    )
                    : null,
            suffixIcon:
                suffixImage != null
                    ? Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image.asset(suffixImage!, height: 15),
                    )
                    : null,
            filled: true,
            fillColor: fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor, width: 2.0),
            ),
          ),
        ),
      ),
    );
  }
}
