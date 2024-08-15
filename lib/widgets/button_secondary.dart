import 'package:flutter/material.dart';

class ButtonSecondary extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const ButtonSecondary({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadiusDirectional.circular(50),
      color: const Color(0xffFFFFFF),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff070623),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
