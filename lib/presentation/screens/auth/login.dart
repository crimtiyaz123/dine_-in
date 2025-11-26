import 'package:dine_in/core/services/widget_support.dart';
// import 'package:dine_in/otp.dart'; // Commented out unused import
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  String phoneNumber = '';
  String enteredPhoneNumber = '';
  bool isLoading = false;
  final TextEditingController _phoneController = TextEditingController();
  
  // OTP related variables
  String otpCode = '';
  bool isOtpMode = false;
  bool isOtpSent = false;
  int _secondsRemaining = 60;
  String _timerText = '';

  @override
  void initState() {
    super.initState();
    _updateTimerText();
  }

  void _updateTimerText() {
    if (_secondsRemaining > 0) {
      _timerText = 'Resend in ${_secondsRemaining}s';
    } else {
      _timerText = 'Resend OTP';
    }
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _updateTimerText();
    
    Future<void> timerFunction() async {
      while (_secondsRemaining > 0 && mounted) {
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          setState(() {
            _secondsRemaining--;
            _updateTimerText();
          });
        }
      }
    }
    
    timerFunction();
  }

  // Validate phone number
  bool _isValidPhoneNumber(String number) {
    if (number.isEmpty) return false;
    // Remove country code and check length
    String cleanedNumber = number.replaceAll(RegExp(r'[^0-9]'), '');
    return cleanedNumber.length >= 10 && cleanedNumber.length <= 15;
  }

  // Send OTP
  Future<void> _sendOTP() async {
    if (!_isValidPhoneNumber(phoneNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid phone number'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Simulate API call to send OTP
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        isLoading = false;
        isOtpMode = true;
        isOtpSent = true;
        enteredPhoneNumber = phoneNumber;
      });

      _startTimer();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP sent successfully! Check your phone'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send OTP: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Verify OTP
  Future<void> _verifyOTP() async {
    if (otpCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a 6-digit OTP'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Simulate API call to verify OTP
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        isLoading = false;
      });

      // Navigate to home screen
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
      
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid OTP. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Resend OTP
  void _resendOTP() {
    if (_secondsRemaining > 0) return;
    
    _sendOTP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 242, 242),
      body: Column(
        children: [
          SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ---------------- LOGO ----------------
                    Image.asset(
                      'images/logo.png',
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  
                    const SizedBox(height: 50),
                    Text(
                      isOtpMode ? "Enter OTP" : "Welcome",
                      textAlign: TextAlign.center,
                      style: AppWidget.HeadlineTextFieldStyle(),
                    ),
                    const SizedBox(height: 10.0),
            
                    Text(
                      isOtpMode ? "Enter the 6-digit code sent to $enteredPhoneNumber" : "Login or Signup",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(221, 113, 127, 131),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
            
                    // ---------------- OTP FIELD ----------------
                    if (isOtpMode) ...[
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        keyboardType: TextInputType.number,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.grey[200],
                          selectedFillColor: Colors.white,
                          activeColor: Colors.green,
                          inactiveColor: Colors.grey,
                          selectedColor: Colors.green,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        errorAnimationController: null,
                        controller: null,
                        onCompleted: (v) {
                          // OTP completed
                        },
                        onChanged: (value) {
                          setState(() {
                            otpCode = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                      ),
                      const SizedBox(height: 20),
                      
                      // Resend OTP button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive code? ",
                            style: TextStyle(color: Colors.grey[600], fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: _resendOTP,
                            child: Text(
                              _timerText,
                              style: TextStyle(
                                color: _secondsRemaining > 0 ? Colors.grey : Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ] else ...[
                      // ---------------- PHONE FIELD ----------------
                      IntlPhoneField(
                        controller: _phoneController,
                        initialCountryCode: 'IN', // <-- show initial country
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          errorStyle: const TextStyle(color: Colors.red),
                        ),
                        keyboardType: TextInputType.phone,
                        onChanged: (phone) {
                          setState(() {
                            phoneNumber = phone.completeNumber;
                          });
                        },
                        onCountryChanged: (country) {
                          print('Country changed to: ${country.name}');
                        },
                      ),
                      const SizedBox(height: 30),
                    ],
            
                    // ---------------- BUTTON ----------------
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : () {
                          if (isOtpMode) {
                            _verifyOTP();
                          } else {
                            _sendOTP();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          disabledBackgroundColor: Colors.grey,
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Text(
                                isOtpMode ? "Verify OTP" : "Continue",
                                style: const TextStyle(fontSize: 18, color: Colors.white),
                              ),
                      ),
                    ),
                    
                    // Back to phone number button (only in OTP mode)
                    if (isOtpMode) ...[
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isOtpMode = false;
                            otpCode = '';
                            isOtpSent = false;
                          });
                        },
                        child: const Text(
                          "Change phone number",
                          style: TextStyle(color: Colors.green, fontSize: 16),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  

