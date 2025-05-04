import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rentyne/model/car_model.dart';
import 'package:rentyne/resources/color_manager.dart';
import 'package:rentyne/resources/url_paths.dart';

class HomeCarItem extends StatefulWidget {
  const HomeCarItem({
    super.key,
    required this.categorizedCars,
    required this.onSelectCar,
    required this.favouriteCars,
  });
  final List<CarModel> categorizedCars;
  final void Function(CarModel car) onSelectCar;
  final List<CarModel> favouriteCars;

  @override
  State<HomeCarItem> createState() => _HomeCarItemState();
}

class _HomeCarItemState extends State<HomeCarItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      //************************* List of car of respective brand name *************************//
      child: widget.categorizedCars.isNotEmpty
          ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: widget.categorizedCars.length,
              itemBuilder: (context, index) {
                final car = widget.categorizedCars[index];
                final isFavourite = widget.favouriteCars.contains(car);

                debugPrint('------------------------------');
                debugPrint('Car - ${index + 1}');
                debugPrint('Car Name : ${car.name}');
                debugPrint('Car image url : ${car.image}');
                debugPrint('Car video url : ${car.videoUrl}');
                return InkWell(
                  onTap: () {
                    widget.onSelectCar(car);
                  },
                  splashColor: Colors.transparent,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 200,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        //************************* Image *************************//
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            "${AppUrl.googleLinkImage}${car.image}",
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        //************************* Favourite Icon *************************//
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (widget.favouriteCars.contains(car)) {
                                  widget.favouriteCars.remove(car);
                                } else {
                                  widget.favouriteCars.add(car);
                                }
                              });

                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  !isFavourite
                                      ? 'Marked as favorite.'
                                      : 'Unmarked as favorite.',
                                ),
                              ));
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: ColorManager.primary,
                              fixedSize: const Size(40, 40),
                            ),
                            icon: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) =>
                                  ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                              child: Icon(
                                isFavourite ? Iconsax.heart5 : Iconsax.heart,
                                color: isFavourite ? Colors.red : null,
                              ),
                            ),
                          ),
                        ),
                        //************************* Car name text *************************//
                        Positioned(
                          bottom: 10,
                          left: 15,
                          right: 15,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                car.name,
                                style: TextStyle(
                                  color: ColorManager.tertiary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  shadows: const [
                                    Shadow(
                                      blurRadius: 5,
                                      color: Colors.black45,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Rs ${car.price.toString()} / day',
                                style: TextStyle(
                                  color: ColorManager.tertiary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  shadows: const [
                                    Shadow(
                                      blurRadius: 5,
                                      color: Colors.black45,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          //************************* Nothing here text (When there is no car in the respective brand) *************************//
          : SizedBox(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Uh ohh...nothing here!",
                      style: TextStyle(
                        fontSize: 24,
                        color: ColorManager.primary,
                      ),
                    ),
                    Text(
                      "Try Selecting a different category",
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorManager.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
