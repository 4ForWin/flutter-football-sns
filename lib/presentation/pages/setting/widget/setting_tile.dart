import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback onTap;

  const SettingTile({
    super.key,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: const Color(0xFFFFFFFF),
      leading: icon != null
          ? Icon(
              icon,
              color: const Color(0xFF2BBB7D),
              size: 24,
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF222222),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            )
          : null,
      trailing: const Icon(
        Icons.chevron_right,
        color: Color(0xFF222222),
        size: 20,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
