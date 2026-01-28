import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool isPassword;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const IosTextField({
    super.key,
    required this.label,
    required this.placeholder,
    this.isPassword = false,
    this.controller,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 78,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFF131313).withOpacity(0.2),
                    const Color(0xFF131313).withOpacity(0.6),
                    const Color(0xFF131313).withOpacity(0.1),
                  ],
                ),
              ),
            ),

            Container(
              width: double.infinity,
              height: 78,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF87858F).withOpacity(0.5),
                  width: 0.5,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFE3E3E3).withOpacity(0.15),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF8E8E93),
                      fontSize: 13,
                      letterSpacing: -0.1,
                      fontFamily: '.SF Pro Display',
                    ),
                  ),

                  const SizedBox(height: 8),

                  SizedBox(
                    height: 24,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        CupertinoTextField(
                          controller: controller,
                          obscureText: isPassword,
                          placeholder: placeholder,
                          onChanged: onChanged,
                          placeholderStyle: TextStyle(
                            color: const Color(0xFF8E8E93).withOpacity(0.6),
                            fontSize: 17,
                            letterSpacing: -0.3,
                            fontFamily: '.SF Pro Display',
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            letterSpacing: -0.3,
                            fontFamily: '.SF Pro Display',
                          ),
                          decoration: null,
                          padding: const EdgeInsets.only(bottom: 6),
                        ),
                        Container(
                          height: 0.5,
                          width: double.infinity,
                          color: const Color(0xFF8E8E93).withOpacity(0.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}