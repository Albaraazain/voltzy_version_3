import 'package:flutter/material.dart';

class ServiceCategoryCard {
  final String id;
  final String name;
  final String description;
  final String iconName;
  final int serviceCount;
  final double minPrice;
  final double maxPrice;
  final Color accentColor;

  const ServiceCategoryCard({
    required this.id,
    required this.name,
    required this.description,
    required this.iconName,
    required this.serviceCount,
    required this.minPrice,
    required this.maxPrice,
    required this.accentColor,
  });

  factory ServiceCategoryCard.fromJson(Map<String, dynamic> json) {
    return ServiceCategoryCard(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      iconName: json['icon_name'],
      serviceCount: 0, // TODO: Implement service count from database
      minPrice: (json['min_price'] as num?)?.toDouble() ?? 0.0,
      maxPrice: (json['max_price'] as num?)?.toDouble() ?? 0.0,
      accentColor: _parseColor(json['accent_color']),
    );
  }

  static Color _parseColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) {
      return Colors.blue; // Default color
    }

    try {
      // Handle hex color strings
      if (colorString.startsWith('#')) {
        return Color(int.parse('FF${colorString.substring(1)}', radix: 16));
      }

      // Handle color name strings
      switch (colorString.toLowerCase()) {
        case 'blue':
          return Colors.blue;
        case 'green':
          return Colors.green;
        case 'orange':
          return Colors.orange;
        case 'red':
          return Colors.red;
        case 'purple':
          return Colors.purple;
        case 'teal':
          return Colors.teal;
        default:
          return Colors.blue;
      }
    } catch (e) {
      return Colors.blue; // Default color on error
    }
  }
}
