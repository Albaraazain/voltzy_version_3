import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';

class ReviewBroadcastScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final String issueDescription;
  final List<String> photos;
  final String location;
  final String urgency;
  final String notes;

  const ReviewBroadcastScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.issueDescription,
    required this.photos,
    required this.location,
    required this.urgency,
    required this.notes,
  });

  Widget _buildReviewSection({
    required IconData icon,
    required String title,
    required Widget content,
    VoidCallback? onEdit,
    Color iconColor = const Color(0xFFF59E0B), // amber-500
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[100]!),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 20, color: iconColor),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              if (onEdit != null)
                Material(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: onEdit,
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        LucideIcons.edit2,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildPhotoGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: photos.map((photo) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[100],
            image: DecorationImage(
              image: NetworkImage(photo),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCoverageIndicator() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            Colors.amber[500]!.withOpacity(0.1),
            Colors.amber[400]!.withOpacity(0.1),
          ],
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(LucideIcons.signal, size: 20, color: Colors.amber[500]),
                  const SizedBox(width: 8),
                  const Text(
                    'Service Coverage',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(LucideIcons.users, size: 16, color: Colors.amber[500]),
                  const SizedBox(width: 8),
                  Text(
                    '8 professionals nearby',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.amber[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 128,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text(
                'Coverage Map Placeholder',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBroadcastInfo() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Colors.amber[500]!.withOpacity(0.1),
            Colors.amber[400]!.withOpacity(0.1),
          ],
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            LucideIcons.info,
            size: 20,
            color: Colors.amber[500],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ready to Broadcast',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.amber[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your request will be sent to qualified professionals in your area. You\'ll be notified as they respond.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.amber[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => context.pop(),
                                  child: const Icon(
                                    LucideIcons.chevronLeft,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  width: 24,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber[50],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.amber[100]!),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    LucideIcons.sparkles,
                                    size: 16,
                                    color: Colors.amber[500],
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    categoryName,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.amber[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Review Request',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Verify your service details before broadcasting',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(24),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildReviewSection(
                        icon: LucideIcons.info,
                        title: 'Issue Description',
                        onEdit: () {},
                        content: Text(
                          issueDescription,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildReviewSection(
                        icon: LucideIcons.camera,
                        title: 'Documentation',
                        onEdit: () {},
                        content: _buildPhotoGrid(),
                      ),
                      const SizedBox(height: 20),
                      _buildReviewSection(
                        icon: LucideIcons.mapPin,
                        title: 'Service Location',
                        onEdit: () {},
                        content: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            location,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildReviewSection(
                        icon: LucideIcons.alertTriangle,
                        title: 'Urgency Level',
                        onEdit: () {},
                        content: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.amber[100]!),
                          ),
                          child: Text(
                            urgency,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.amber[600],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildCoverageIndicator(),
                      const SizedBox(height: 20),
                      _buildBroadcastInfo(),
                      const SizedBox(height: 100),
                    ]),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.amber[500]!,
                      Colors.amber[400]!,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber[500]!.withOpacity(0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      context.push('/homeowner/request-service/review/finding',
                          extra: {
                            'categoryId': categoryId,
                            'categoryName': categoryName,
                          });
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text(
                          'Broadcast Request',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
