import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/service_category_card.dart';
import '../widgets/location_selector_widget.dart';
import '../providers/service_category_provider.dart';
import 'category_services_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/auth_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _selectedDifficulty = 'Emergency';

  @override
  Widget build(BuildContext context) {
    final categoriesState = ref.watch(serviceCategoryProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(LucideIcons.menu),
                    onPressed: _showMenu,
                  ),
                  const LocationSelectorWidget(),
                ],
              ),
            ),

            // Welcome text
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Text(
                'What service do you need?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Difficulty selector
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  'Emergency',
                  'Regular',
                  'Maintenance',
                ].map((difficulty) {
                  final isSelected = _selectedDifficulty == difficulty;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ChoiceChip(
                      label: Text(difficulty),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _selectedDifficulty = difficulty);
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            // Categories grid
            Expanded(
              child: categoriesState.when(
                data: (categories) => GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return _buildCategoryCard(category);
                  },
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Error loading categories',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref
                            .read(serviceCategoryProvider.notifier)
                            .loadCategories(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(ServiceCategoryCard category) {
    return InkWell(
      onTap: () => context.push('/homeowner/category/${category.id}'),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                LucideIcons.wrench, // TODO: Map iconName to actual icons
                size: 32,
                color: category.accentColor,
              ),
              const Spacer(),
              Text(
                category.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                category.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                '\$${category.minPrice.toStringAsFixed(0)} - \$${category.maxPrice.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMenu() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation1, animation2) => Container(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          )),
          child: FadeTransition(
            opacity: animation,
            child: Material(
              elevation: 0,
              color: Colors.transparent,
              child: Stack(
                children: [
                  // Semi-transparent overlay
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  // Menu content
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.amber.shade400,
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(32)),
                    ),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Menu',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(LucideIcons.x,
                                      color: Colors.white, size: 28),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                          _buildAnimatedMenuItem(
                            LucideIcons.home,
                            'Home',
                            animation,
                            0,
                            onTap: () {
                              Navigator.pop(context);
                              context.go('/homeowner');
                            },
                          ),
                          _buildAnimatedMenuItem(
                            LucideIcons.heart,
                            'Favorites',
                            animation,
                            1,
                            onTap: () {
                              Navigator.pop(context);
                              // TODO: Navigate to favorites
                            },
                          ),
                          _buildAnimatedMenuItem(
                            LucideIcons.clock,
                            'My Jobs',
                            animation,
                            2,
                            onTap: () {
                              Navigator.pop(context);
                              context.go('/homeowner/active-jobs');
                            },
                          ),
                          _buildAnimatedMenuItem(
                            LucideIcons.user,
                            'Profile',
                            animation,
                            3,
                            onTap: () {
                              Navigator.pop(context);
                              context.go('/homeowner/profile');
                            },
                          ),
                          const Divider(color: Colors.white24, height: 32),
                          _buildAnimatedMenuItem(
                            LucideIcons.settings,
                            'Settings',
                            animation,
                            4,
                            onTap: () {
                              Navigator.pop(context);
                              context.push('/homeowner/profile/settings');
                            },
                          ),
                          _buildAnimatedMenuItem(
                            LucideIcons.helpCircle,
                            'Help & Support',
                            animation,
                            5,
                            onTap: () {
                              Navigator.pop(context);
                              context.push('/homeowner/profile/help');
                            },
                          ),
                          const Spacer(),
                          _buildAnimatedMenuItem(
                            LucideIcons.logOut,
                            'Sign Out',
                            animation,
                            6,
                            onTap: () async {
                              Navigator.pop(context);
                              try {
                                await ref.read(authProvider.notifier).signOut();
                                if (context.mounted) {
                                  context.go('/');
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error signing out: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedMenuItem(
    IconData icon,
    String title,
    Animation<double> animation,
    int index, {
    VoidCallback? onTap,
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Interval(
          0.4 + (index * 0.1),
          1.0,
          curve: Curves.easeOutCubic,
        ),
      )),
      child: FadeTransition(
        opacity: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Interval(
            0.4 + (index * 0.1),
            1.0,
            curve: Curves.easeOut,
          ),
        )),
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            leading: Icon(icon, color: Colors.white, size: 28),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
