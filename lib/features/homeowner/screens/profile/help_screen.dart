import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';

class HomeownerHelpScreen extends StatelessWidget {
  const HomeownerHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          onPressed: () => context.pop(),
          color: Colors.black,
        ),
        title: const Text(
          'Help Center',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[100]!),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.search,
                      size: 20,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search help articles',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Quick Actions
              Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey[100]!),
                ),
                child: Column(
                  children: [
                    _buildQuickAction(
                      icon: LucideIcons.messageCircle,
                      title: 'Contact Support',
                      subtitle: 'Get help from our team',
                      onTap: () {
                        // TODO: Navigate to contact support
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildQuickAction(
                      icon: LucideIcons.messageSquare,
                      title: 'Live Chat',
                      subtitle: 'Chat with a support agent',
                      onTap: () {
                        // TODO: Open live chat
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Help Categories
              Text(
                'Help Categories',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey[100]!),
                ),
                child: Column(
                  children: [
                    _buildHelpCategory(
                      icon: LucideIcons.home,
                      title: 'Getting Started',
                      articleCount: 12,
                      onTap: () {
                        // TODO: Navigate to getting started articles
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildHelpCategory(
                      icon: LucideIcons.wallet,
                      title: 'Payments & Billing',
                      articleCount: 8,
                      onTap: () {
                        // TODO: Navigate to payment articles
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildHelpCategory(
                      icon: LucideIcons.wrench,
                      title: 'Services & Booking',
                      articleCount: 15,
                      onTap: () {
                        // TODO: Navigate to services articles
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildHelpCategory(
                      icon: LucideIcons.shield,
                      title: 'Safety & Security',
                      articleCount: 6,
                      onTap: () {
                        // TODO: Navigate to safety articles
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // FAQs
              Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey[100]!),
                ),
                child: Column(
                  children: [
                    _buildFaqItem(
                      question: 'How do I book a service?',
                      onTap: () {
                        // TODO: Show booking service help
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildFaqItem(
                      question: 'What payment methods are accepted?',
                      onTap: () {
                        // TODO: Show payment methods help
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildFaqItem(
                      question: 'How do I cancel a booking?',
                      onTap: () {
                        // TODO: Show cancellation help
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 20,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              size: 20,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpCategory({
    required IconData icon,
    required String title,
    required int articleCount,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 20,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              '$articleCount articles',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              LucideIcons.chevronRight,
              size: 20,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem({
    required String question,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                question,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              size: 20,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
