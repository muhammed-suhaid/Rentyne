import 'package:flutter/material.dart';
import 'package:rentyne/screens/home_screen/widgets/home_appbar.dart';
import 'package:rentyne/screens/home_screen/widgets/home_categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 24,
        bottom: MediaQuery.of(context).padding.bottom + 24,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeAppbar(),
          HomeCategories(),
        ],
      ),
    );
  }
}
