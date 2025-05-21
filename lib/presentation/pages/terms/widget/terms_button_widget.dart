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
    return Center(
      child: ElevatedButton(
        onPressed: (){}, 
        child: Text('동의')
      ),
    );
  }
}