import 'package:flutter/material.dart';

enum CardSize { small, medium, large }

class ServiceCategoryCard extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final String iconName;
  final int serviceCount;
  final double minPrice;
  final double maxPrice;
  final CardSize size;
  final MaterialColor accentColor;

  const ServiceCategoryCard({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.iconName,
    required this.serviceCount,
    required this.minPrice,
    required this.maxPrice,
    this.size = CardSize.medium,
    required this.accentColor,
  });

  String get _imagePath {
    switch (name.toLowerCase()) {
      case 'electrical services':
        return 'assets/images/electrical_services.png';
      case 'plumbing services':
        return 'assets/images/plumbing_services.png';
      case 'hvac services':
        return 'assets/images/hvac_services.png';
      case 'landscaping services':
        return 'assets/images/landscaping_services.png';
      case 'security services':
        return 'assets/images/security_services.png';
      case 'smart home services':
        return 'assets/images/smart_home_services.png';
      case 'cleaning services':
        return 'assets/images/home_cleaning_services.png';
      case 'carpentry services':
        return 'assets/images/carpentry_services.png';
      case 'painting services':
        return 'assets/images/painting_services.png';
      case 'solar services':
        return 'assets/images/solar_services.png';
      case 'appliance repair services':
        return 'assets/images/appliance_repair_services.png';
      default:
        return 'assets/images/default_service.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: DecorationImage(
          image: AssetImage(_imagePath),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 0.5,
              ),
            ),
            child: Text(
              name.replaceAll(' Services', ''),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.2,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
