class Environment {
  static const String development = 'development';
  static const String staging = 'staging';
  static const String production = 'production';

  static String get currentEnvironment {
    const String environment = String.fromEnvironment('environment', defaultValue: development);
    return environment;
  }

  static bool get isDevelopment => currentEnvironment == development;
  static bool get isStaging => currentEnvironment == staging;
  static bool get isProduction => currentEnvironment == production;

  static String get baseUrl {
    switch (currentEnvironment) {
      case production:
        return 'https://api.dinein.com';
      case staging:
        return 'https://staging-api.dinein.com';
      case development:
      default:
        return 'https://dev-api.dinein.com';
    }
  }
}