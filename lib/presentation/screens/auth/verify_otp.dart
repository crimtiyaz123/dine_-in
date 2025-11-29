import 'package:flutter/material.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/helpers/validators.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter the OTP sent to your phone',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              _otpController,
              hintText: 'Enter OTP',
              keyboardType: TextInputType.number,
              validator: (value) => Validators.validateRequired(value, 'OTP'),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Verify',
              onPressed: () {
                // Implement OTP verification logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
