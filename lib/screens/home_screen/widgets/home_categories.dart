import 'package:flutter/material.dart';
import 'package:rentyne/model/car_model.dart';
import 'package:rentyne/resources/color_manager.dart';
import 'package:rentyne/screens/car_detail_screen/car_detail_screen.dart';
import 'package:rentyne/screens/home_screen/widgets/home_car_item.dart';

class HomeCategories extends StatefulWidget {
  const HomeCategories({
    super.key,
    required this.availableCars,
    required this.favouriteCars,
  });
  final List<Car> availableCars;
  final List<Car> favouriteCars;

  @override
  State<HomeCategories> createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories> {
  int currentBrand = 0;
  List<String> brand = [
    "BMW",
    "Porsche",
    "Benz",
    "Tesla",
  ];
  List<Car> filteredCars = [];

  List<Car> _categorizedCars(String brand) {
    return filteredCars =
        widget.availableCars.where((car) => car.brand.contains(brand)).toList();
  }

  void onSelectCar(BuildContext context, Car car) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CarDetailsScreen(car: car),
      ),
    );
  }

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
            //************************* List view fort Brand container *************************//
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: brand.length,
              itemBuilder: (context, index) {
                //************************* Brand container *************************//
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      currentBrand = index;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: currentBrand == index
                          ? ColorManager.secondary
                          : ColorManager.primary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Text(
                        brand[index],
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: currentBrand == index
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
        HomeCarItem(
          categorizedCars: _categorizedCars(
            brand[currentBrand],
          ),
          onSelectCar: (Car car) {
            onSelectCar(context, car);
          },
          favouriteCars: widget.favouriteCars,
        ),
      ],
    );
  }
}
