import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

final _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
  ),
);

class AppShell extends StatelessWidget {
  final Widget child;
  final String currentPath;
  final bool isProfessional;

  const AppShell({
    super.key,
    required this.child,
    required this.currentPath,
    required this.isProfessional,
  });

  int _findBestMatchingIndex(String location, List<_NavItem> items) {
    // First try exact match
    final exactMatch = items.indexWhere((item) => item.path == location);
    if (exactMatch != -1) {
      return exactMatch;
    }

    // If no exact match, find the longest matching prefix
    int bestIndex = -1;
    int longestMatch = 0;

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      if (location.startsWith(item.path) && item.path.length > longestMatch) {
        longestMatch = item.path.length;
        bestIndex = i;
      }
    }

    _logger.d('🔍 Path Matching:'
        '\n  - Location: $location'
        '\n  - Best Match Index: $bestIndex'
        '\n  - Match Length: $longestMatch'
        '\n  - Matched Path: ${bestIndex >= 0 ? items[bestIndex].path : "none"}');

    return bestIndex;
  }

  @override
  Widget build(BuildContext context) {
    final items = isProfessional ? _professionalItems : _homeownerItems;
    final location = GoRouterState.of(context).uri.path;
    final currentIndex = _findBestMatchingIndex(location, items);

    _logger.i('🔄 AppShell rebuilding:'
        '\n  - Current Path: $currentPath'
        '\n  - Router Location: $location'
        '\n  - isProfessional: $isProfessional');

    _logger.d('📍 Navigation Index:'
        '\n  - Calculated Index: $currentIndex'
        '\n  - Matched Path: ${currentIndex >= 0 ? items[currentIndex].path : "none"}'
        '\n  - Available Paths: ${items.map((e) => e.path).toList()}');

    return Scaffold(
      body: child,
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: FlashyTabBar(
            height: 65,
            selectedIndex: currentIndex >= 0 ? currentIndex : 0,
            showElevation: false,
            backgroundColor: Colors.white,
            onItemSelected: (index) {
              final targetPath = items[index].path;
              _logger.i('🎯 Navigation Requested:'
                  '\n  - Current Index: $currentIndex'
                  '\n  - Target Index: $index'
                  '\n  - Current Path: $location'
                  '\n  - Target Path: $targetPath');

              if (index != currentIndex) {
                _logger.d('🚀 Executing Navigation:'
                    '\n  - From: $location'
                    '\n  - To: $targetPath');
                context.go(targetPath);
              } else {
                _logger.d('⏭️ Navigation Skipped - Already at index $index');
              }
            },
            items: items
                .map((item) => FlashyTabBarItem(
                      icon: Icon(item.icon),
                      title: Text(item.label),
                      activeColor: Theme.of(context).colorScheme.primary,
                      inactiveColor: Colors.grey.shade400,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String path;
  final IconData icon;

  const _NavItem({
    required this.label,
    required this.path,
    required this.icon,
  });
}

const _homeownerItems = [
  _NavItem(
    label: 'Dashboard',
    path: '/homeowner',
    icon: Icons.dashboard_outlined,
  ),
  _NavItem(
    label: 'Jobs',
    path: '/homeowner/active-jobs',
    icon: Icons.work_outline,
  ),
  _NavItem(
    label: 'Messages',
    path: '/homeowner/messages',
    icon: Icons.message_outlined,
  ),
  _NavItem(
    label: 'Profile',
    path: '/homeowner/profile',
    icon: Icons.person_outline,
  ),
];

const _professionalItems = [
  _NavItem(
    label: 'Dashboard',
    path: '/professional',
    icon: Icons.dashboard_outlined,
  ),
  _NavItem(
    label: 'Jobs',
    path: '/professional/jobs',
    icon: Icons.work_outline,
  ),
  _NavItem(
    label: 'Active Job',
    path: '/professional/jobs/active',
    icon: Icons.engineering_outlined,
  ),
  _NavItem(
    label: 'Messages',
    path: '/professional/messages',
    icon: Icons.message_outlined,
  ),
  _NavItem(
    label: 'Profile',
    path: '/professional/profile',
    icon: Icons.person_outline,
  ),
];
