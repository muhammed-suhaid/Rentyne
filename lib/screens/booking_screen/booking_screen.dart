import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:rentyne/model/booking_model.dart';
import 'package:rentyne/model/car_model.dart';
import 'package:rentyne/resources/color_manager.dart';
import 'package:rentyne/resources/url_paths.dart';
import 'package:rentyne/services/booking_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key, required this.car});

  final CarModel car;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  int? userId;

  @override
  void initState() {
    super.initState();
    _fetchUserId();
  }

  Future<void> _pickStartDate() async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        if (_endDate != null && _startDate!.isAfter(_endDate!)) {
          _endDate = null;
        }
      });
    }
  }

  Future<void> _pickEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate!.add(const Duration(days: 1)),
      firstDate: _startDate!.add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //************************* Appbar *************************//
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ColorManager.tertiary,
        ),
        title: Text(
          'Book ${widget.car.name}',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: ColorManager.secondary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),

      //************************* Body *************************//
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //************************* Car image *************************//
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                "${AppUrl.googleLink}${widget.car.videoUrl}",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            //************************* Car Name text *************************//
            Text(
              widget.car.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: ColorManager.secondary,
              ),
            ),
            //************************* Car cost text *************************//
            const SizedBox(height: 10),
            Text(
              'Cost per day : ${widget.car.price}/-',
              style: TextStyle(
                fontSize: 18,
                color: ColorManager.tertiary,
              ),
            ),
            const SizedBox(height: 5),
            //************************* Car Rating text *************************//
            Row(
              children: [
                Text(
                  'Rating: ${widget.car.rating}',
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
            //************************* Description text *************************//
            const SizedBox(height: 10),
            Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                color: ColorManager.tertiary,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.car.description,
              style: TextStyle(
                fontSize: 14,
                color: ColorManager.primary,
              ),
            ),
            const SizedBox(height: 30),
            //************************* Start date and End date button row *************************//
            Row(
              children: [
                // Start Date Button
                Expanded(
                  child: InkWell(
                    onTap: _pickStartDate,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: 55,
                      decoration: BoxDecoration(
                        color: _startDate == null
                            ? Colors.red
                            : ColorManager.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          _startDate != null
                              ? DateFormat('dd/MM/yyyy').format(_startDate!)
                              : "Start Date",
                          style: TextStyle(
                            color: _startDate != null
                                ? Colors.black
                                : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // End Date Button
                Expanded(
                  child: InkWell(
                    onTap: _startDate != null ? _pickEndDate : null,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: 55,
                      decoration: BoxDecoration(
                        color: _endDate != null
                            ? ColorManager.secondary
                            : Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          _endDate != null
                              ? DateFormat('dd/MM/yyyy').format(_endDate!)
                              : "End Date",
                          style: TextStyle(
                            color:
                                _endDate != null ? Colors.black : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //************************* Total date selected and also the price *************************//
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_startDate != null && _endDate != null) ...[
                  Text(
                    'Total Days: ${_endDate!.difference(_startDate!).inDays}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.tertiary),
                  ),
                  Text(
                    'Total Cost: Rs ${double.parse(widget.car.price.toString()) * _endDate!.difference(_startDate!).inDays}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.tertiary),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 10),
            //************************* Confirm Booking button *************************//
            InkWell(
              onTap: (_startDate != null &&
                      _endDate != null &&
                      widget.car.isAvailable)
                  ? () {
                      if (userId != null) {
                        final formattedStart =
                            DateFormat('yyyy-MM-dd').format(_startDate!);
                        final formattedEnd =
                            DateFormat('yyyy-MM-dd').format(_endDate!);

                        debugPrint("-----------------------------------------");
                        debugPrint("Car ID : ${widget.car.id.toString()}");
                        debugPrint("User ID : ${userId.toString()}");
                        debugPrint("start date : $formattedStart");
                        debugPrint("end date : $formattedEnd");
                        debugPrint("-----------------------------------------");

                        onButtonPressed(
                          context,
                          carId: widget.car.id,
                          userId: userId!,
                          startDate: formattedStart,
                          endDate: formattedEnd,
                        );
                      }
                    }
                  : null,
              child: Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: (_startDate != null && _endDate != null)
                      ? ColorManager.secondary
                      : Colors.red,
                  // Disabled state
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    (_startDate != null && _endDate != null)
                        ? "Confirm Booking"
                        : "Select Dates",
                    style: TextStyle(
                      color: (_startDate != null && _endDate != null)
                          ? Colors.black
                          : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//************************* Shared preference *************************//
  Future<void> _fetchUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId');
    });
  }

//************************* onButton Pressed *************************//
  Future<void> onButtonPressed(
    BuildContext context, {
    required int carId,
    required int userId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      await createBooking(
        carId: carId,
        userId: userId,
        startDate: startDate,
        endDate: endDate,
      ).then((response) {
        if (response is BookingModel) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Booking successful!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
          debugPrint("Booking successful!");
          debugPrint("Booking ID: ${response.booking?.id}");
        } else if (response is Map && response.containsKey('error')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response['error']),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      });
    } catch (e) {
      debugPrint("Booking Error: $e");
    }
  }
}
