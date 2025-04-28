import 'package:flutter/material.dart';
import 'package:rentyne/model/car_model.dart';
import 'package:rentyne/screens/home_screen/widgets/home_appbar.dart';
import 'package:rentyne/screens/home_screen/widgets/home_categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.availableCars,
    required this.favouriteCars,
  });
  final List<Car> availableCars;
  final List<Car> favouriteCars;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 24,
        bottom: MediaQuery.of(context).padding.bottom + 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeAppbar(),
          HomeCategories(
            availableCars: availableCars,
            favouriteCars: favouriteCars,
          ),
        ],
      ),
    );
  }
}
