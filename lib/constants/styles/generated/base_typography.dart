import 'package:flutter/material.dart';

class BaseTypography {
  BaseTypography({required this.textTheme});

   final TextTheme textTheme;

	TextStyle? get headline100 => textTheme.displayLarge?.copyWith(fontFamily: 'Roboto', fontWeight: FontWeight.w600, fontSize: 34, letterSpacing: 0,);
	TextStyle? get headline200 => textTheme.displayMedium?.copyWith(fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 28, letterSpacing: 0,);
	TextStyle? get headline300 => textTheme.displaySmall?.copyWith(fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 24, letterSpacing: 0,);
	TextStyle? get headline400 => textTheme.headlineMedium?.copyWith(fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 20, letterSpacing: 0,);
	TextStyle? get headline500 => textTheme.headlineSmall?.copyWith(fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 20, letterSpacing: 0,);
	TextStyle? get headline600 => textTheme.titleLarge?.copyWith(fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 18, letterSpacing: 0,);
	TextStyle? get subtitle100 => textTheme.titleMedium?.copyWith(fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 16, letterSpacing: 0,);
	TextStyle? get subtitle200 => textTheme.titleSmall?.copyWith(fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 16, letterSpacing: 0,);
	TextStyle? get subtitle300 => textTheme.titleSmall?.copyWith(fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 14, letterSpacing: 0,);
	TextStyle? get body100 => textTheme.bodyLarge?.copyWith(fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 16, letterSpacing: 0,);
	TextStyle? get body200 => textTheme.bodyMedium?.copyWith(fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 14, letterSpacing: 0,);
	TextStyle? get body300 => textTheme.bodySmall?.copyWith(fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 12, letterSpacing: 0,);
	TextStyle? get button => textTheme.labelLarge?.copyWith(fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 14, letterSpacing: 0,);
	TextStyle? get caption => textTheme.bodySmall?.copyWith(fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 12, letterSpacing: 0,);
	TextStyle? get overline => textTheme.labelSmall?.copyWith(fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 12, letterSpacing: 0,);
}