import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voltzy_version_3/shared/models/nav_item.dart';

class ScaffoldWithNav extends StatelessWidget {
  final List<NavItem> navItems;
  final List<NavItem> drawerItems;
  final String userName;
  final String userRole;
  final Widget child;

  const ScaffoldWithNav({
    Key? key,
    required this.navItems,
    required this.drawerItems,
    required this.userName,
    required this.userRole,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    // Find the current index based on the location
    final currentIndex = navItems.indexWhere(
      (item) => location.startsWith(item.path),
    );

    return Scaffold(
      body: child,
      drawer: _buildDrawer(context),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex >= 0 ? currentIndex : 0,
        onDestinationSelected: (index) {
          // Only navigate if we're not already on the selected tab
          if (index != currentIndex) {
            context.go(navItems[index].path);
          }
        },
        destinations: navItems
            .map((item) => NavigationDestination(
                  icon: Icon(item.icon),
                  label: item.label,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: Text(userRole),
            currentAccountPicture: CircleAvatar(
              child: Text(userName[0].toUpperCase()),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ...drawerItems.map((item) => ListTile(
                leading: Icon(item.icon),
                title: Text(item.label),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  context.go(item.path);
                },
              )),
        ],
      ),
    );
  }
}
