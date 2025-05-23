import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mercenaryhub/presentation/pages/home/widgets/home_bottom_navigation_bar.dart';
import 'package:mercenaryhub/presentation/pages/home/widgets/home_indexed_stack.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/write_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: HomeIndexedStack(),
        bottomNavigationBar: HomeBottomNavigationBar());
  }
}
