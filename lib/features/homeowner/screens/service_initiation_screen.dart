import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';

class ServiceInitiationScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final Map<String, dynamic> professional;
  final Map<String, dynamic> service;

  const ServiceInitiationScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.professional,
    required this.service,
  });

  Widget _buildSelectedProfessional() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.amber[50]!,
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.amber[100]!,
                            Colors.amber[50]!,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          professional['name']
                              .split(' ')
                              .map((n) => n[0])
                              .join(''),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.amber[700],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            professional['name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    LucideIcons.star,
                                    size: 16,
                                    color: Colors.amber[500],
                                    fill: 1,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    professional['rating'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                LucideIcons.shield,
                                size: 16,
                                color: Colors.grey[500],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Verified Pro',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(LucideIcons.navigation,
                                        size: 16, color: Colors.grey[500]),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${professional['distance']} away',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  width: 1,
                                  height: 16,
                                  color: Colors.grey[200],
                                ),
                                const SizedBox(width: 16),
                                Row(
                                  children: [
                                    Icon(LucideIcons.clock,
                                        size: 16, color: Colors.grey[500]),
                                    const SizedBox(width: 8),
                                    Text(
                                      'ETA ${professional['eta']}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceDetails() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Service Details',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green[100]!),
                  ),
                  child: Text(
                    'Confirmed',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.green[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    LucideIcons.alertTriangle,
                    size: 16,
                    color: Colors.amber[500],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      service['description'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    LucideIcons.mapPin,
                    size: 16,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      service['location'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactButtons() {
    return Row(
      children: [
        Expanded(
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
                  // TODO: Implement message functionality
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        LucideIcons.messageCircle,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Message',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // TODO: Implement call functionality
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.phone,
                        color: Colors.grey[700],
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Call',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusInfo() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Colors.green[500]!.withOpacity(0.1),
            Colors.green[400]!.withOpacity(0.1),
          ],
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            LucideIcons.checkCircle,
            size: 20,
            color: Colors.green[500],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Professional is preparing',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.green[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'You\'ll be notified when they\'re on their way',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green[600],
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
        child: CustomScrollView(
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
                      'Service Confirmed',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Professional has been notified and is preparing',
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
                  _buildSelectedProfessional(),
                  const SizedBox(height: 20),
                  _buildServiceDetails(),
                  const SizedBox(height: 20),
                  _buildContactButtons(),
                  const SizedBox(height: 20),
                  _buildStatusInfo(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
