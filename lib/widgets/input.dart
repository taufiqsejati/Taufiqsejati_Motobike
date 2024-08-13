import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String icon;
  final String hint;
  final TextEditingController editingController;
  final bool? obsecure;
  final bool enable;
  final VoidCallback? onTapBox;
  const Input(
      {super.key,
      required this.icon,
      required this.hint,
      required this.editingController,
      this.obsecure,
      this.enable = false,
      this.onTapBox});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTapBox,
        child: TextField(
          controller: editingController,
        ));
  }
}
