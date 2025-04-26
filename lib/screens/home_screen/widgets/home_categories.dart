import 'package:flutter/material.dart';
import 'package:rentyne/resources/color_manager.dart';

class HomeCategories extends StatefulWidget {
  const HomeCategories({super.key});

  @override
  State<HomeCategories> createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories> {
  int currentCategory = 0;
  List<String> category = [
    "BMW",
    "Porsche",
    "Benz",
    "Tesla",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          //************************* Title *************************//
          child: Text(
            "Top Brands",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.tertiary,
                ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 40,
            //************************* List view fort Category container *************************//
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: category.length,
              itemBuilder: (context, index) {
                //************************* Category container *************************//
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      currentCategory = index;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: currentCategory == index
                          ? ColorManager.secondary
                          : ColorManager.primary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Text(
                        category[index],
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: currentCategory == index
                                  ? Colors.black
                                  : Colors.black.withOpacity(0.5),
                            ),
                      ),
                    ),
                  ),
                );
              },
              //************************* Separator sizedBox *************************//
              separatorBuilder: (context, index) => const SizedBox(width: 10),
            ),
          ),
        ),
      ],
    );
  }
}
