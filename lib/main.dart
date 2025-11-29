import 'package:flutter/material.dart';

import 'presentation/screens/splash/onboarding.dart';
import 'presentation/screens/auth/login.dart';
import 'presentation/screens/auth/signup.dart';
import 'presentation/screens/auth/verify_otp.dart';
import 'presentation/screens/profile/payment.dart' as profile_payment;
import 'presentation/routes/main_navigation.dart';
import 'presentation/screens/restaurant/auth/restaurant_splash_screen.dart';
import 'presentation/screens/restaurant/auth/restaurant_login_page.dart';
import 'presentation/screens/restaurant/auth/restaurant_otp_verification.dart';
import 'presentation/screens/restaurant/auth/restaurant_profile_setup.dart';
import 'presentation/screens/restaurant/dashboard/orders_navigation.dart';
import 'presentation/screens/restaurant/dashboard/restaurant_dashboard_page.dart';
import 'presentation/screens/orders/order.dart';
import 'presentation/screens/payments/payment_page.dart';
import 'presentation/screens/payments/payment_success.dart';
import 'presentation/screens/profile/promotional_codes.dart';
import 'presentation/screens/profile/delivery_schedule.dart';
import 'presentation/screens/profile/address_management.dart';
import 'presentation/screens/profile/edit_profile.dart';
import 'presentation/screens/profile/favorites_page.dart';
import 'presentation/screens/profile/profile_page.dart';
import 'presentation/screens/settings/customer_support.dart';
import 'presentation/screens/home/search_page.dart';
import 'presentation/screens/home/restaurant_details.dart' as home_restaurant;
import 'presentation/screens/cart/cart_item.dart';
import 'presentation/screens/cart/cart_page.dart';
import 'presentation/screens/orders/order_tracking.dart';
import 'presentation/screens/orders/orders_page.dart';
import 'presentation/screens/orders/order_history.dart';
import 'presentation/live_location_page.dart';
import 'presentation/screens/restaurant/orders/new_orders_page.dart';
import 'presentation/screens/restaurant/orders/accepted_orders_page.dart';
import 'presentation/screens/restaurant/orders/assign_driver_page.dart';
import 'presentation/screens/restaurant/orders/completed_orders_page.dart';
import 'presentation/screens/restaurant/menu/menu_list_page.dart';
import 'presentation/screens/restaurant/menu/food_items_list_page.dart';
import 'presentation/screens/restaurant/menu/add_edit_category_page.dart';
import 'presentation/screens/restaurant/menu/add_edit_food_item_page.dart';
import 'presentation/screens/restaurant/settings/business_hours_page.dart';
import 'presentation/screens/restaurant/settings/payment_banking_page.dart';
import 'presentation/screens/restaurant/analytics/order_reports_page.dart';
import 'presentation/screens/restaurant/support/help_faq_page.dart';
import 'config/app_theme.dart';

// Conditional import: use real service for mobile, stub for Web
import 'core/services/notification_service.dart'
    if (dart.library.html) 'core/services/notification_service_stub.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notifications only for supported platforms
  await NotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dine In',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const RestaurantDashboardPage(),
      routes: {
        '/onboarding': (context) => const Onboarding(),
        '/login': (context) => const PhoneLoginPage(),
        '/signup': (context) => const SignupScreen(),
        '/verify-otp': (context) => const VerifyOtpScreen(),
        '/home': (context) => const MainNavigation(),
        '/restaurant/login': (context) => const RestaurantLoginPage(),
        '/restaurant/otp': (context) => const RestaurantOtpVerificationPage(),
        '/restaurant/profile-setup': (context) => const RestaurantProfileSetupPage(),
        '/restaurant/dashboard': (context) => const RestaurantDashboardPage(),
        '/restaurant/orders': (context) => OrdersNavigationPage(),
        '/payment': (context) => const PaymentPage(),
        '/order': (context) => const OrderPage(orderType: "delivery", restaurantName: "Restaurant"),
        '/promotional-codes': (context) => const PromotionalCodesPage(),
        '/delivery-schedule': (context) => const DeliverySchedulePage(orderAmount: 0.0),
        '/address-management': (context) => const AddressManagementPage(),
        '/customer-support': (context) => const CustomerSupportPage(),
        '/search': (context) => const SearchPage(),
        '/cart': (context) => const CartItemPage(cartType: "delivery", restaurantName: "Restaurant"),
        '/order-tracking': (context) => const OrderTrackingPage(orderId: "12345", restaurantName: "Restaurant", estimatedTime: "30 mins"),
        '/orders': (context) => const OrdersPage(),
        '/profile': (context) => const ProfilePage(),
        '/favorites': (context) => const FavoritesPage(),
        '/edit-profile': (context) => const EditProfilePage(),
        '/order-history': (context) => const OrderHistoryPage(),
        '/payment-success': (context) => const PaymentSuccessPage(),

        '/cart-page': (context) => CartPage(),
        '/live-location': (context) => LiveLocationPage(),
        '/restaurant/new-orders': (context) => const NewOrdersPage(),
        '/restaurant/accepted-orders': (context) => const AcceptedOrdersPage(),
        '/restaurant/assign-driver': (context) => const AssignDriverPage(),
        '/restaurant/completed-orders': (context) => const CompletedOrdersPage(),
        '/restaurant/menu': (context) => const MenuListPage(),
        '/restaurant/food-items': (context) => const FoodItemsListPage(),
        '/restaurant/add-category': (context) => const AddEditCategoryPage(),
        '/restaurant/add-food-item': (context) => const AddEditFoodItemPage(),
        '/restaurant/business-hours': (context) => const BusinessHoursPage(),
        '/restaurant/payment-banking': (context) => const PaymentBankingPage(),
        '/restaurant/analytics': (context) => const OrderReportsPage(),
        '/restaurant/support': (context) => const HelpFaqPage(),
      },
    );
  }
}
