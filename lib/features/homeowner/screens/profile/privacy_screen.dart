import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';

class HomeownerPrivacyScreen extends StatefulWidget {
  const HomeownerPrivacyScreen({super.key});

  @override
  State<HomeownerPrivacyScreen> createState() => _HomeownerPrivacyScreenState();
}

class _HomeownerPrivacyScreenState extends State<HomeownerPrivacyScreen> {
  bool locationSharing = true;
  bool profileVisibility = true;
  bool dataCollection = true;
  bool thirdPartySharing = false;
  bool marketingConsent = false;

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
          'Privacy',
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
              // Privacy Settings
              Text(
                'Privacy Settings',
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
                    _buildPrivacySwitch(
                      icon: LucideIcons.mapPin,
                      title: 'Location Sharing',
                      subtitle: 'Share your location with professionals',
                      value: locationSharing,
                      onChanged: (value) {
                        setState(() => locationSharing = value);
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildPrivacySwitch(
                      icon: LucideIcons.userCircle,
                      title: 'Profile Visibility',
                      subtitle: 'Make your profile visible to professionals',
                      value: profileVisibility,
                      onChanged: (value) {
                        setState(() => profileVisibility = value);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Data Privacy
              Text(
                'Data Privacy',
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
                    _buildPrivacySwitch(
                      icon: LucideIcons.barChart2,
                      title: 'Data Collection',
                      subtitle:
                          'Allow collection of usage data to improve services',
                      value: dataCollection,
                      onChanged: (value) {
                        setState(() => dataCollection = value);
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildPrivacySwitch(
                      icon: LucideIcons.share2,
                      title: 'Third-Party Sharing',
                      subtitle: 'Share data with trusted partners',
                      value: thirdPartySharing,
                      onChanged: (value) {
                        setState(() => thirdPartySharing = value);
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildPrivacySwitch(
                      icon: LucideIcons.mail,
                      title: 'Marketing Consent',
                      subtitle: 'Receive marketing communications',
                      value: marketingConsent,
                      onChanged: (value) {
                        setState(() => marketingConsent = value);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Privacy Links
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey[100]!),
                ),
                child: Column(
                  children: [
                    _buildPrivacyLink(
                      icon: LucideIcons.fileText,
                      title: 'Privacy Policy',
                      onTap: () {
                        // TODO: Navigate to privacy policy
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildPrivacyLink(
                      icon: LucideIcons.scroll,
                      title: 'Terms of Service',
                      onTap: () {
                        // TODO: Navigate to terms of service
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildPrivacyLink(
                      icon: LucideIcons.trash2,
                      title: 'Delete Account',
                      isDestructive: true,
                      onTap: () {
                        // TODO: Show delete account confirmation
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  // TODO: Save privacy settings
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[400],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Save Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrivacySwitch({
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

  Widget _buildPrivacyLink({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
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
                color: isDestructive ? Colors.red[500] : Colors.grey[600],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDestructive ? Colors.red[500] : Colors.black,
                ),
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              size: 20,
              color: isDestructive ? Colors.red[500] : Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
