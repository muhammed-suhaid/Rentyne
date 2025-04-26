import 'dart:async';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final TextEditingController searchController = TextEditingController();

  final List<String> carSuggestions = [
    "Porsche 911 GT3 RS",
    "BMW M4",
    "Bentley Continental",
    "Audi R8",
    "BMW M340i",
    "Lamborghini Huracán",
    "Ferrari 488",
    "Mercedes AMG GT",
    "Rolls Royce Ghost",
    "Tesla Model S",
    "Aston Martin DB11",
  ];

  int currentHintIndex = 0;
  Timer? hintTimer;
  bool hasValue = false;

  @override
  void initState() {
    super.initState();
    startHintTextTimer();
  }

  //************************* Timer method that refresh the text in each 3 sec *************************//

  void startHintTextTimer() {
    hintTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        currentHintIndex = (currentHintIndex + 1) % carSuggestions.length;
      });
    });
  }

  void onSearchChanged(String value) {
    setState(() {
      hasValue = value.isNotEmpty;
    });
  }

  @override
  void dispose() {
    hintTimer?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.only(left: 16, right: 8),
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          //************************* search icon *************************//
          const Icon(Icons.search),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                //************************* Aniamted text that changes in each 3 sec *************************//
                if (!hasValue)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: Align(
                      key: ValueKey<String>(carSuggestions[currentHintIndex]),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        carSuggestions[currentHintIndex],
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.5),
                            ),
                      ),
                    ),
                  ),
                //************************* Text form field *************************//
                TextFormField(
                  controller: searchController,
                  cursorColor: const Color.fromARGB(255, 167, 251, 1),
                  onChanged: onSearchChanged,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    suffixIcon: hasValue
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              searchController.clear();
                              setState(() {
                                hasValue = false;
                              });
                            },
                          )
                        : null,
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
