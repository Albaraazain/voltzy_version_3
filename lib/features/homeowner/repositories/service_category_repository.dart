import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/errors/app_error.dart';
import '../models/service_category_card.dart';
import '../../../core/config/feature_flags.dart';

abstract class ServiceCategoryRepository {
  Future<List<ServiceCategoryCard>> getServiceCategories();
}

class FirebaseServiceCategoryRepository implements ServiceCategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<ServiceCategoryCard>> getServiceCategories() async {
    try {
      final querySnapshot = await _firestore
          .collection('service_categories')
          .where('is_active', isEqualTo: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return ServiceCategoryCard(
          id: doc.id,
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          iconName: data['icon_name'] ?? '',
          serviceCount: data['service_count'] ?? 0,
          minPrice: (data['min_price'] as num?)?.toDouble() ?? 0.0,
          maxPrice: (data['max_price'] as num?)?.toDouble() ?? 0.0,
          accentColor: _parseColor(data['accent_color']),
        );
      }).toList();
    } catch (e) {
      throw AppError(context: 'ServiceCategoryRepository', message: 'Failed to fetch service categories: ${e.toString()}');
    }
  }

  Color _parseColor(String? colorString) {
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

class MockServiceCategoryRepository implements ServiceCategoryRepository {
  @override
  Future<List<ServiceCategoryCard>> getServiceCategories() async {
    // Simulated delay
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      ServiceCategoryCard(
        id: '1',
        name: 'Electrical Services',
        description: 'Professional electrical services',
        iconName: 'electrical',
        serviceCount: 150,
        minPrice: 50,
        maxPrice: 500,
        accentColor: Colors.blue,
      ),
      ServiceCategoryCard(
        id: '2',
        name: 'Plumbing Services',
        description: 'Expert plumbing solutions',
        iconName: 'plumbing',
        serviceCount: 120,
        minPrice: 75,
        maxPrice: 800,
        accentColor: Colors.orange,
      ),
      ServiceCategoryCard(
        id: '3',
        name: 'HVAC Services',
        description: 'Complete HVAC maintenance',
        iconName: 'hvac',
        serviceCount: 90,
        minPrice: 100,
        maxPrice: 1500,
        accentColor: Colors.green,
      ),
      ServiceCategoryCard(
        id: '4',
        name: 'Cleaning Services',
        description: 'Professional cleaning services',
        iconName: 'cleaning',
        serviceCount: 200,
        minPrice: 30,
        maxPrice: 300,
        accentColor: Colors.teal,
      ),
    ];
  }
}

final serviceCategoryRepositoryProvider =
    Provider<ServiceCategoryRepository>((ref) {
  if (FeatureFlags.useFirebaseServiceCategories) {
    return FirebaseServiceCategoryRepository();
  }
  return MockServiceCategoryRepository();
});
