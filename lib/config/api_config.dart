class ApiConfig {
  static const String baseUrl = 'https://api.example.com';
  static const String apiKey = 'your_api_key_here';
  static const Duration timeout = Duration(seconds: 30);

  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String restaurantsEndpoint = '/restaurants';
  static const String ordersEndpoint = '/orders';
  static const String userProfileEndpoint = '/user/profile';
}
