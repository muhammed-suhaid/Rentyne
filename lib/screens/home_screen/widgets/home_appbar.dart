import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rentyne/resources/color_manager.dart';
import 'package:rentyne/screens/home_screen/widgets/home_search_bar.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              //************************* Title *************************//
              Text(
                "Discover Premium\nCars",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.secondary,
                    ),
              ),
              const Spacer(),
              //************************* Notification Iconbutton *************************//
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SizedBox(),
                    ),
                  );
                },
                icon: const Icon(Iconsax.notification),
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: ColorManager.secondary,
                  fixedSize: const Size(50, 50),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        //************************* Search bar *************************//
        const HomeSearchBar()
      ],
    );
  }
}
