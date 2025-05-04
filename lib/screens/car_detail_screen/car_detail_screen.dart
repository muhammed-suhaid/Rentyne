import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rentyne/resources/url_paths.dart';
import 'package:video_player/video_player.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rentyne/model/car_model.dart';
import 'package:rentyne/resources/color_manager.dart';
import 'package:rentyne/screens/booking_screen/booking_screen.dart';

class CarDetailsScreen extends StatefulWidget {
  const CarDetailsScreen({super.key, required this.car});
  final CarModel car;

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  // Initialize the video
  void _initializeVideo() {
    _controller =
        VideoPlayerController.networkUrl(Uri.parse("${AppUrl.googleLink}${widget.car.videoUrl}"))
          ..initialize().then((_) {
            setState(() {});
            _controller.setVolume(0);
            _controller.play();
            _controller.setLooping(true);
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.isInitialized
          ? Stack(
              children: [
                //******************* Video Background *******************//
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
                //******************* Overlay UI *******************//
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //******************* Back button *******************//
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _controller.pause();
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back_ios),
                              style: IconButton.styleFrom(
                                backgroundColor: ColorManager.secondary,
                                fixedSize: const Size(50, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        //******************* Car name and rating *******************//
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Car name
                            Text(
                              widget.car.name,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: ColorManager.tertiary,
                              ),
                            ),
                            // Rating
                            Row(
                              children: [
                                Text(
                                  widget.car.rating.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: ColorManager.tertiary,
                                  ),
                                ),
                                Icon(
                                  Iconsax.star1,
                                  size: 20,
                                  color: Colors.yellow.shade700,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        //******************* Book Now Buttons *******************//
                        InkWell(
                          onTap: () {
                            if (widget.car.isAvailable) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      BookingScreen(car: widget.car),
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: widget.car.isAvailable
                                  ? ColorManager.secondary
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                widget.car.isAvailable
                                    ? "Book Now"
                                    : "Not Available",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: widget.car.isAvailable
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Container(
                key: const ValueKey(1),
                color: Colors.black.withOpacity(0.9),
                child: Center(
                  child: Lottie.asset(
                    AnimationAssets.loading,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
    );
  }
}
