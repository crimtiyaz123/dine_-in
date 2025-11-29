import 'package:flutter/material.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/helpers/validators.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Enter your payment details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                _cardNumberController,
                hintText: 'Card Number',
                keyboardType: TextInputType.number,
                validator: (value) => Validators.validateRequired(value, 'Card Number'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      _expiryController,
                      hintText: 'Expiry (MM/YY)',
                      validator: (value) => Validators.validateRequired(value, 'Expiry'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      _cvvController,
                      hintText: 'CVV',
                      keyboardType: TextInputType.number,
                      validator: (value) => Validators.validateRequired(value, 'CVV'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                _nameController,
                hintText: 'Cardholder Name',
                validator: (value) => Validators.validateRequired(value, 'Cardholder Name'),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Pay Now',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process payment
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
