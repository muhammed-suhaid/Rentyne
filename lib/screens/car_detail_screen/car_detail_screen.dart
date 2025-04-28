import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rentyne/model/car_model.dart';
import 'package:rentyne/resources/color_manager.dart';
import 'package:rentyne/screens/booking_screen/booking_screen.dart';

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({
    super.key,
    required this.car,
  });
  final Car car;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              //************************* image *************************//
              Container(
                width: double.infinity,
                height: 350,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  car.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              //************************* Back button *************************//
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(Icons.arrow_back_ios),
                    ),
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.grey[300],
                      fixedSize: const Size(50, 50),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //************************* Car name text and Rating text *************************//
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  car.name,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.tertiary,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      car.rating,
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorManager.tertiary,
                      ),
                    ),
                    Icon(
                      Iconsax.star1,
                      size: 18,
                      color: Colors.yellow.shade700,
                    ),
                  ],
                ),
              ],
            ),
          ),
          //************************* Price text *************************//
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Row(
              children: [
                Text(
                  'Price : ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.tertiary,
                  ),
                ),
                Text(
                  '${car.cost} / Day',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.tertiary,
                  ),
                ),
              ],
            ),
          ),
          //************************* Description Heading *************************//
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 5),
            child: Row(
              children: [
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.tertiary,
                  ),
                ),
              ],
            ),
          ),
          //************************* Description text *************************//
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),
          ),
          //************************* Favourite button and booking button *************************//
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Row(
              children: [
                //************************* Favourite button *************************//
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        car.isAvailable ? ColorManager.secondary : Colors.red,
                    foregroundColor:
                        car.isAvailable ? ColorManager.secondary : Colors.red,
                    shadowColor:
                        car.isAvailable ? ColorManager.secondary : Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  child: Icon(
                    Icons.favorite_border_outlined,
                    color: car.isAvailable ? Colors.black : Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                //************************* Booking button *************************//
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (car.isAvailable) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingScreen(car: car),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        color: car.isAvailable
                            ? ColorManager.secondary
                            : Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          car.isAvailable ? "Book Now" : "Not Available",
                          style: TextStyle(
                            color:
                                car.isAvailable ? Colors.black : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
