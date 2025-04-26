import 'package:flutter/material.dart';

class GetStartedModel {
  final String image;
  final String title;
  final String subtitle;
  final Alignment textAlignment;

  GetStartedModel({
    required this.image,
    required this.title,
    required this.subtitle,
    this.textAlignment = Alignment.bottomLeft,
  });
}
