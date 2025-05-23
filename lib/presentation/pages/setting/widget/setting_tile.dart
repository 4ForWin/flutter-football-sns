import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SettingTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: const Color(0xFFFFFFFF),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF222222),
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Color(0xFF222222),
      ),
      onTap: onTap,
    );
  }
}
