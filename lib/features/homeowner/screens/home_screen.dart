import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/service_category_card.dart';
import '../widgets/location_selector_widget.dart';
import 'category_services_screen.dart';

class HomeownerHomeScreen extends StatefulWidget {
  const HomeownerHomeScreen({super.key});

  @override
  State<HomeownerHomeScreen> createState() => _HomeownerHomeScreenState();
}

class _HomeownerHomeScreenState extends State<HomeownerHomeScreen> {
  bool _isLoading = false;
  List<ServiceCategoryCard> _categories = [];
  String _selectedDifficulty = 'Emergency';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      // Simulated data loading
      await Future.delayed(const Duration(seconds: 1));
      final cardCategories = [
        ServiceCategoryCard(
          id: '1',
          name: 'Electrical Services',
          description: 'Professional electrical services',
          iconName: 'electrical',
          serviceCount: 5,
          minPrice: 89.99,
          maxPrice: 1999.99,
          size: CardSize.medium,
          accentColor: Colors.blue,
        ),
        ServiceCategoryCard(
          id: '2',
          name: 'Plumbing Services',
          description: 'Expert plumbing solutions',
          iconName: 'plumbing',
          serviceCount: 5,
          minPrice: 89.99,
          maxPrice: 1999.99,
          size: CardSize.medium,
          accentColor: Colors.orange,
        ),
        ServiceCategoryCard(
          id: '3',
          name: 'HVAC Services',
          description: 'Complete HVAC maintenance',
          iconName: 'hvac',
          serviceCount: 5,
          minPrice: 89.99,
          maxPrice: 1999.99,
          size: CardSize.medium,
          accentColor: Colors.green,
        ),
        ServiceCategoryCard(
          id: '4',
          name: 'Cleaning Services',
          description: 'Professional cleaning services',
          iconName: 'cleaning',
          serviceCount: 5,
          minPrice: 89.99,
          maxPrice: 1999.99,
          size: CardSize.medium,
          accentColor: Colors.teal,
        ),
      ];

      setState(() => _categories = cardCategories);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading data: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
                            onTap: () {
                              Navigator.pop(context);
                              // TODO: Implement sign out
                              context.go('/');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _loadData,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: _showMenu,
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border:
                                          Border.all(color: Colors.grey[200]!),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 16,
                                          height: 2,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[800],
                                            borderRadius:
                                                BorderRadius.circular(1),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          width: 12,
                                          height: 2,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[800],
                                            borderRadius:
                                                BorderRadius.circular(1),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          width: 8,
                                          height: 2,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[800],
                                            borderRadius:
                                                BorderRadius.circular(1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border:
                                        Border.all(color: Colors.grey[200]!),
                                  ),
                                  child: Icon(
                                    LucideIcons.bell,
                                    size: 24,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome Back!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'What service do you need today?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: LocationSelectorWidget(),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(24),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.85,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final category = _categories[index];
                            return GestureDetector(
                              onTap: () {
                                context
                                    .push('/homeowner/request-service', extra: {
                                  'categoryId': category.id,
                                  'categoryName': category.name,
                                  'categoryColor': category.accentColor,
                                });
                              },
                              child: category,
                            );
                          },
                          childCount: _categories.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
