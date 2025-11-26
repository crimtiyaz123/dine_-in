import 'package:dine_in/presentation/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
// import 'home.dart'; // Commented out unused import

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  const OtpPage({super.key, required this.phoneNumber});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('images/logo.png', height: 120, fit: BoxFit.contain),
              const SizedBox(height: 20),
              const Text(
                "Enter OTP",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "OTP sent to ${widget.phoneNumber}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 88, 48, 48)),
              ),
              const SizedBox(height: 40),

              // ---------------- PIN CODE FIELDS ----------------
              PinCodeTextField(
                appContext: context,
                length: 4, // 4-digit OTP
                controller: otpController,
                keyboardType: TextInputType.number,
                animationType: AnimationType.scale,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  fieldHeight: 60,
                  fieldWidth: 60,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.grey.shade200,
                  selectedFillColor: Colors.white,
                  activeColor: const Color.fromARGB(255, 230, 204, 7),
                  selectedColor: Colors.green,
                  inactiveColor: Colors.grey,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                onChanged: (value) {},
              ),

              const SizedBox(height: 30),

              // VERIFY BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                 onPressed: () {
  if (otpController.text.length == 4) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }
},

                  
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Verify",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
