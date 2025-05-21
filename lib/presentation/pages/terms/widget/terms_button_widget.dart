import 'package:flutter/material.dart';

class TermsButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onPressed;

  const TermsButton({
    super.key,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled ? Color(0xff2BBB7D) : Color(0xffE8EEF2),
          foregroundColor: enabled ? Color(0xffFFFFFF) : Color(0xffA4ADB2),
          textStyle: const TextStyle(
            fontSize: 16,
            fontFamily: 'Pretendard'
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          )
        ), 
        child: const Text("동의")
      )
    );
  }
}