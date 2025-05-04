import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rentyne/model/car_model.dart';
import 'package:rentyne/resources/color_manager.dart';
import 'package:rentyne/screens/home_screen/home_screen.dart';
import 'package:rentyne/screens/my_booking_screen/my_booking_screen.dart';
import 'package:rentyne/services/car_service.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageindex = 0;

  List<CarModel> availableCars = [];
  List<CarModel> favouriteCars = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCarData();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage;

    if (isLoading) {
      activePage = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (errorMessage.isNotEmpty) {
      activePage = Center(
        child: Text(
          errorMessage,
          style: const TextStyle(color: Colors.white),
        ),
      );
    } else {
      //************************* Pages selection condition *************************//
      activePage = HomeScreen(
        availableCars: availableCars,
        favouriteCars: favouriteCars,
      );
    }
    if (_selectedPageindex == 1) {
      activePage = const MyBookingScreen();
    }
    if (_selectedPageindex == 2) {
      activePage = const SizedBox();
    }

    //************************* Body and Icons *************************//
    return Scaffold(
      backgroundColor: Colors.black,
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageindex,
        backgroundColor: Colors.black,
        selectedItemColor: ColorManager.secondary,
        unselectedItemColor: ColorManager.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home5),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_sharp),
            label: 'My Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Future<void> fetchCarData() async {
    try {
      final fetchedCars = await fetchCars();
      setState(() {
        availableCars = fetchedCars;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'FSomething went wrong!';
        isLoading = false;
      });
    }
  }
}
