import 'package:flutter/material.dart';
import 'package:rentyne/model/get_satrted_model.dart';
import 'package:rentyne/resources/asset_manager.dart';

final List<GetStartedModel> pages = [
  GetStartedModel(
    image: ImageAssets.getStarted1,
    title: 'Ignite Your Passion',
    subtitle: 'Experience the unmatched thrill and precision of Porsche. Rent your dream today.',
    textAlignment: Alignment.bottomLeft,
  ),
  GetStartedModel(
    image: ImageAssets.getStarted2,
    title: 'Luxury Without Limits',
    subtitle: 'Indulge in world-class comfort and sophistication behind every mile.',
    textAlignment: Alignment.topLeft,
  ),
  GetStartedModel(
    image: ImageAssets.getStarted3,
    title: 'Born to Perform',
    subtitle: 'Feel the raw power and dynamic driving spirit of BMW M. Your ultimate drive awaits.',
    textAlignment: Alignment.bottomLeft,
  ),
];
