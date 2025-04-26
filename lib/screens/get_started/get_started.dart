import 'package:flutter/material.dart';
import 'package:rentyne/data/get_satarted_data.dart';
import 'package:rentyne/resources/color_manager.dart';
import 'package:rentyne/screens/components/tabs.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  int _currentPage = 0;
  bool _isBlackScreen = true;

  void _nextPage() {
    setState(() {
      _isBlackScreen = true;
    });

    //************************* Adding delay before moving to the next page *************************//
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_currentPage < pages.length - 1) {
        setState(() {
          _currentPage++;
        });
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const TabsScreen(),
          ),
        );
      }
    });
  }

//************************* Skip Method *************************//
  void _skip() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const TabsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //*************************  Black fade background during transition *************************//
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: _isBlackScreen ? 1.0 : 0.0,
            child: const ColoredBox(
              color: Colors.black,
              child: SizedBox.expand(),
            ),
          ),

          //************************* Page View with smooth fade-in transitionn *************************//
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 700),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: SizedBox(
              key: ValueKey<int>(_currentPage),
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  Image.asset(
                    pages[_currentPage].image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  //************************* Gradient overlay *************************//
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        stops: [0.1, 1],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  //************************* Title and Subtitle *************************//
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      MediaQuery.of(context).padding.top + 16,
                      16,
                      MediaQuery.of(context).padding.bottom + 120,
                    ),
                    child: Align(
                      alignment: pages[_currentPage].textAlignment,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pages[_currentPage].title,
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            pages[_currentPage].subtitle,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //************************* Page Indicators *************************//
          Positioned(
            top: MediaQuery.of(context).size.height * 0.20,
            right: 16,
            child: Column(
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  width: 8,
                  height: _currentPage == index ? 20 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? ColorManager.secondary
                        : Colors.white54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),

          //************************* Skip and Get Start Buttons *************************//
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 30,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _skip,
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                InkWell(
                  onTap: _nextPage,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: ColorManager.secondary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.center,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Get Start',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
