import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CategoryServicesScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final MaterialColor categoryColor;

  const CategoryServicesScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
        title: Text(
          categoryName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Services for $categoryName will be displayed here',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
