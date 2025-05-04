import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rentyne/data/car_data.dart';
import 'package:rentyne/model/car_model.dart';
import 'package:rentyne/resources/color_manager.dart';
import 'package:rentyne/screens/home_screen/home_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageindex = 0;
  List<Car> favouriteCars = [];

  void _selectPage(int index) {
    setState(() {
      _selectedPageindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableCars = carList;
    Widget activePage = HomeScreen(
      availableCars: availableCars,
      favouriteCars: favouriteCars,
    );

    //************************* Pages selection condition *************************//
    if (_selectedPageindex == 1) {
      activePage = const SizedBox();
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
            icon: Icon(Iconsax.heart5),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
