import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final double elevation;
  final EdgeInsets padding;
  final TextStyle? textStyle;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.elevation = 0.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor, // Button color
        foregroundColor: textColor, // Text color
        padding: padding, // Padding inside the button
        elevation: elevation, // Shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius), // Border radius
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style:
            textStyle ??
            GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xff1DA1FA),
            ),
      ),
    );
  }
}
