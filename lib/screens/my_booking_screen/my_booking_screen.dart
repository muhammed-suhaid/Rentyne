import 'package:flutter/material.dart';
import 'package:rentyne/model/my_booking_model.dart';
import 'package:rentyne/resources/color_manager.dart';
import 'package:rentyne/resources/url_paths.dart';
import 'package:rentyne/services/delete_booking.dart';
import 'package:rentyne/services/my_booking_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  List<MyBookingModel> _bookings = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //************************* AppBar ********************//
      appBar: AppBar(
        title: const Text('My Bookings'),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      //************************* Loading ********************//
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          //error
          : _errorMessage != null
              ? Center(
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: ColorManager.tertiary,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              //booking is empty
              : _bookings.isEmpty
                  ? Center(
                      child: Text(
                        "No bookings found",
                        style: TextStyle(
                          color: ColorManager.tertiary,
                        ),
                      ),
                    )
                  //************************* my booking display tile ********************//
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _bookings.length,
                      itemBuilder: (context, index) {
                        final booking = _bookings[index];
                        final car = booking.carDetails;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          //************************* car details ********************//
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  "${AppUrl.googleLink}${car.image}",
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Car name
                              Text(
                                car.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.secondary,
                                ),
                              ),
                              // Car brand
                              Text(
                                'Brand: ${car.brand}',
                                style: TextStyle(
                                  color: ColorManager.tertiary,
                                ),
                              ),
                              // Start date
                              Text(
                                'Start: ${booking.startDate}',
                                style: TextStyle(
                                  color: ColorManager.tertiary,
                                ),
                              ),
                              // End date
                              Text(
                                'End: ${booking.endDate}',
                                style: TextStyle(
                                  color: ColorManager.tertiary,
                                ),
                              ),
                              // price per day
                              Text(
                                'Price per day: ₹${car.price}',
                                style: TextStyle(
                                  color: ColorManager.tertiary,
                                ),
                              ),
                              // Status
                              const SizedBox(height: 8),
                              Text(
                                booking.isConfirmed
                                    ? 'Status: Confirmed'
                                    : booking.isCancelled
                                        ? 'Status: Cancelled'
                                        : 'Status: Pending',
                                style: TextStyle(
                                  color: booking.isConfirmed
                                      ? Colors.green
                                      : booking.isCancelled
                                          ? Colors.red
                                          : Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              //************************* Delete Button ********************//
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[700],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () =>
                                      _showDeleteConfirmationDialog(booking.id),
                                  icon: const Icon(Icons.delete,
                                      color: Colors.white),
                                  label: const Text(
                                    'Cancel Booking',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
    );
  }

  //************************* _fetchBookings function ********************//
  Future<void> _fetchBookings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId');
      debugPrint("User Id : $userId");

      if (userId != null) {
        final bookings = await fetchBookings(userId);
        setState(() {
          _bookings = bookings;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = "User not logged in.";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  //************************* Cancel Booking Confirmation method ********************//

  void _showDeleteConfirmationDialog(int bookingId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Cancel Booking',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to cancel this booking?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _cancelBooking(context, bookingId);
            },
            child: const Text('Yes', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

//************************* Cancel Booking Method ********************//

  Future<void> _cancelBooking(BuildContext context, int bookingId) async {
  setState(() {
    _isLoading = true;
  });

  deleteBooking(bookingId).then((response) {
    debugPrint("Booking id : $bookingId");

    if (response is Map && response['success'] == true) {
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Booking cancelled successfully'),
      //       backgroundColor: Colors.green,
      //       duration: Duration(seconds: 2),
      //       behavior: SnackBarBehavior.floating,
      //     ),
      //   );
      // }

      debugPrint("Booking cancelled successfully");
      _fetchBookings();
    } else {
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text("Failed to cancel booking"),
      //       backgroundColor: Colors.red,
      //       behavior: SnackBarBehavior.floating,
      //     ),
      //   );
      // }

      debugPrint("Failed to cancel booking");
      setState(() {
        _isLoading = false;
      });
    }
  }).catchError((error) {
    // if (mounted) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('An error occurred: $error'),
    //       backgroundColor: Colors.red,
    //       behavior: SnackBarBehavior.floating,
    //     ),
    //   );
    // }
    debugPrint("An error occurred");
    setState(() {
      _isLoading = false;
    });
  });
}

}
