class FeatureFlags {
  // Core Features
  static const useSupabaseAuth = true;
  static const useSupabaseProfiles = true;

  // Service Features
  static const useSupabaseServiceCategories = false;
  static const useSupabaseJobs = false;

  // Advanced Features
  static const useSupabaseNotifications = false;
  static const useSupabaseChat = false;
  static const useSupabasePayments = false;

  // Development Features
  static const logSupabaseErrors = true;
  static const useSupabaseErrorLogging = true;
}
