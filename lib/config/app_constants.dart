class AppConstants {
  // App Information
  static const String appName = 'Dine In';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const String baseUrl = 'https://api.dinein.com';
  static const String apiVersion = 'v1';
  
  // Cache Keys
  static const String userCacheKey = 'user_data';
  static const String authTokenKey = 'auth_token';
  static const String cartCacheKey = 'cart_data';
  static const String preferencesKey = 'app_preferences';

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Padding & Margin Values
  static const double smallPadding = 8.0;
  static const double mediumPadding = 16.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 32.0;

  // Border Radius
  static const double smallBorderRadius = 4.0;
  static const double mediumBorderRadius = 8.0;
  static const double largeBorderRadius = 12.0;
  static const double extraLargeBorderRadius = 16.0;

  // Elevation Values
  static const double lowElevation = 2.0;
  static const double mediumElevation = 4.0;
  static const double highElevation = 8.0;

  // Image Assets Paths
  static const String imagesPath = 'assets/images/';
  static const String iconsPath = 'assets/icons/';
  static const String fontsPath = 'assets/fonts/';

  // Default Values
  static const int defaultPageSize = 20;
  static const int maxRetryAttempts = 3;
  static const Duration requestTimeout = Duration(seconds: 30);
}