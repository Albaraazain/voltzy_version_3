import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';

class HomeownerSettingsScreen extends StatefulWidget {
  const HomeownerSettingsScreen({super.key});

  @override
  State<HomeownerSettingsScreen> createState() =>
      _HomeownerSettingsScreenState();
}

class _HomeownerSettingsScreenState extends State<HomeownerSettingsScreen> {
  String selectedLanguage = 'English';
  String selectedTheme = 'Light';
  bool biometricEnabled = true;
  bool autoSave = true;
  bool offlineMode = false;

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
          'App Settings',
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
              // General Settings
              Text(
                'General',
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
                    _buildSettingsItem(
                      icon: LucideIcons.languages,
                      title: 'Language',
                      value: selectedLanguage,
                      onTap: () {
                        _showLanguageSelector(context);
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildSettingsItem(
                      icon: LucideIcons.palette,
                      title: 'Theme',
                      value: selectedTheme,
                      onTap: () {
                        _showThemeSelector(context);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Security Settings
              Text(
                'Security',
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
                    _buildSettingsSwitch(
                      icon: LucideIcons.fingerprint,
                      title: 'Biometric Authentication',
                      subtitle: 'Use fingerprint or face ID',
                      value: biometricEnabled,
                      onChanged: (value) {
                        setState(() => biometricEnabled = value);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // App Preferences
              Text(
                'App Preferences',
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
                    _buildSettingsSwitch(
                      icon: LucideIcons.save,
                      title: 'Auto-Save',
                      subtitle: 'Automatically save changes',
                      value: autoSave,
                      onChanged: (value) {
                        setState(() => autoSave = value);
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildSettingsSwitch(
                      icon: LucideIcons.wifi,
                      title: 'Offline Mode',
                      subtitle: 'Access app features without internet',
                      value: offlineMode,
                      onChanged: (value) {
                        setState(() => offlineMode = value);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // App Information
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey[100]!),
                ),
                child: Column(
                  children: [
                    _buildSettingsItem(
                      icon: LucideIcons.info,
                      title: 'About App',
                      onTap: () {
                        // TODO: Navigate to about screen
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildSettingsItem(
                      icon: LucideIcons.bookOpen,
                      title: 'Documentation',
                      onTap: () {
                        // TODO: Navigate to documentation
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Version Info
              Center(
                child: Text(
                  'Version 1.0.0 (Build 100)',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    String? value,
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
            if (value != null) ...[
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 8),
            ],
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

  Widget _buildSettingsSwitch({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.amber[400],
          ),
        ],
      ),
    );
  }

  void _showLanguageSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            _buildLanguageOption('English'),
            _buildLanguageOption('Spanish'),
            _buildLanguageOption('French'),
            _buildLanguageOption('German'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language) {
    return InkWell(
      onTap: () {
        setState(() => selectedLanguage = language);
        context.pop();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                language,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (selectedLanguage == language)
              Icon(
                LucideIcons.check,
                size: 20,
                color: Colors.amber[400],
              ),
          ],
        ),
      ),
    );
  }

  void _showThemeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            _buildThemeOption('Light'),
            _buildThemeOption('Dark'),
            _buildThemeOption('System'),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(String theme) {
    return InkWell(
      onTap: () {
        setState(() => selectedTheme = theme);
        context.pop();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                theme,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (selectedTheme == theme)
              Icon(
                LucideIcons.check,
                size: 20,
                color: Colors.amber[400],
              ),
          ],
        ),
      ),
    );
  }
}
