import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';

class HomeownerNotificationsScreen extends StatefulWidget {
  const HomeownerNotificationsScreen({super.key});

  @override
  State<HomeownerNotificationsScreen> createState() =>
      _HomeownerNotificationsScreenState();
}

class _HomeownerNotificationsScreenState
    extends State<HomeownerNotificationsScreen> {
  bool pushEnabled = true;
  bool emailEnabled = true;
  bool smsEnabled = false;

  // Notification preferences
  bool serviceUpdates = true;
  bool professionalArrival = true;
  bool paymentAlerts = true;
  bool promotions = false;
  bool tips = true;

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
          'Notifications',
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
              // Notification Channels
              Text(
                'Notification Channels',
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
                    _buildChannelSwitch(
                      icon: LucideIcons.bell,
                      title: 'Push Notifications',
                      subtitle: 'Receive notifications on your device',
                      value: pushEnabled,
                      onChanged: (value) {
                        setState(() => pushEnabled = value);
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildChannelSwitch(
                      icon: LucideIcons.mail,
                      title: 'Email Notifications',
                      subtitle: 'Receive updates via email',
                      value: emailEnabled,
                      onChanged: (value) {
                        setState(() => emailEnabled = value);
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildChannelSwitch(
                      icon: LucideIcons.messageSquare,
                      title: 'SMS Notifications',
                      subtitle: 'Receive text message alerts',
                      value: smsEnabled,
                      onChanged: (value) {
                        setState(() => smsEnabled = value);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Notification Types
              Text(
                'Notification Types',
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
                    _buildNotificationTypeSwitch(
                      title: 'Service Updates',
                      subtitle: 'Status changes and important updates',
                      value: serviceUpdates,
                      onChanged: (value) {
                        setState(() => serviceUpdates = value);
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildNotificationTypeSwitch(
                      title: 'Professional Arrival',
                      subtitle: 'When professional is arriving',
                      value: professionalArrival,
                      onChanged: (value) {
                        setState(() => professionalArrival = value);
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildNotificationTypeSwitch(
                      title: 'Payment Alerts',
                      subtitle: 'Charges and payment confirmations',
                      value: paymentAlerts,
                      onChanged: (value) {
                        setState(() => paymentAlerts = value);
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildNotificationTypeSwitch(
                      title: 'Promotions & Offers',
                      subtitle: 'Deals and special offers',
                      value: promotions,
                      onChanged: (value) {
                        setState(() => promotions = value);
                      },
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    _buildNotificationTypeSwitch(
                      title: 'Tips & Recommendations',
                      subtitle: 'Helpful tips for your home',
                      value: tips,
                      onChanged: (value) {
                        setState(() => tips = value);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  // TODO: Save notification preferences
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
                  'Save Preferences',
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

  Widget _buildChannelSwitch({
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

  Widget _buildNotificationTypeSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
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
}
