import 'package:flutter/material.dart';

class DrinkItem {
  const DrinkItem({
    required this.name,
    required this.category,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.color,
    required this.options,
  });

  final String name;
  final String category;
  final String subtitle;
  final String description;
  final int price;
  final double rating;
  final String imageUrl;
  final Color color;
  final List<String> options;
}
