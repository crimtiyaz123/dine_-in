import 'package:dine_in/presentation/screens/auth/login.dart';
import 'package:dine_in/presentation/routes/main_navigation.dart';
import 'package:dine_in/presentation/screens/splash/onboarding.dart';
import 'package:dine_in/presentation/screens/profile/payment.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dine In',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Onboarding(),
      routes: {
        '/login': (context) => const PhoneLoginPage(),
        '/home': (context) => const MainNavigation(),
        '/payment': (context) => const PaymentPage(
          orderType: "delivery",
          restaurantName: "Restaurant",
        ),
      },
    );
  }
}
