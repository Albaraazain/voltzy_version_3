import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/service_category_card.dart';
import '../widgets/location_selector_widget.dart';
import '../providers/service_category_provider.dart';
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
        child: categoriesState.when(
          data: (categories) => RefreshIndicator(
            onRefresh: () async {
              ref.read(serviceCategoryProvider.notifier).loadCategories();
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 24),
                        Text(
                          'Welcome Back!',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'What service do you need today?',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: LocationSelectorWidget(),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(24),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final category = categories[index];
                        return _buildServiceCard(category);
                      },
                      childCount: categories.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
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
                  onPressed: () =>
                      ref.read(serviceCategoryProvider.notifier).loadCategories(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: _showMenu,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      width: 24,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 24,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 24,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Home Services of any Type',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(ServiceCategoryCard category) {
    String imagePath = 'assets/images/';
    final name = category.name.toLowerCase().replaceAll(' services', '');
    
    switch (name) {
      case 'electrical':
        imagePath += 'electrical_services.png';
        break;
      case 'plumbing':
        imagePath += 'plumbing_services.png';
        break;
      case 'hvac':
        imagePath += 'hvac_services.png';
        break;
      case 'landscaping':
        imagePath += 'landscaping_services.png';
        break;
      case 'security':
        imagePath += 'security_services.png';
        break;
      case 'smart home':
        imagePath += 'smart_home_services.png';
        break;
      case 'home cleaning':
      case 'cleaning':
        imagePath += 'home_cleaning_services.png';
        break;
      case 'carpentry':
        imagePath += 'carbentry_services.png';
        break;
      case 'painting':
        imagePath += 'painting_services.png';
        break;
      case 'solar':
        imagePath += 'solar_services.png';
        break;
      case 'appliance':
      case 'appliance repair':
        imagePath += 'appliance_repair_services.png';
        break;
      default:
        imagePath += 'default_service.png';
    }

    return GestureDetector(
      onTap: () => context.push('/homeowner/category/${category.id}'),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          image: DecorationImage(
            image: AssetImage(imagePath),
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
                category.name.replaceAll(' Services', ''),
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
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Favorites coming soon!'),
                                ),
                              );
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
