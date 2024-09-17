import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/sign_up_bloc/bloc.dart';
import '../bloc/sign_up_bloc/events.dart';
import '../bloc/sign_up_bloc/states.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String? verificationId; // Store the verificationId
  bool _isOtpSent = false; // Track whether OTP has been sent

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Phone Authentication")),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PhoneVerificationCodeSent) {
            setState(() {
              verificationId = state.verificationId;
              _isOtpSent = true; // Update state to show OTP input
            });
          } else if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              if (!_isOtpSent)
                ElevatedButton(
                  onPressed: () {
                    final phoneNumber = phoneController.text;
                    if (phoneNumber.isNotEmpty) {
                      // Trigger send verification code event
                      context.read<AuthBloc>().add(
                        SendVerificationCodeRequested(phoneNumber: phoneNumber),
                      );
                    }
                  },
                  child: const Text("Send OTP"),
                ),
              if (_isOtpSent) ...[
                const SizedBox(height: 16),
                TextField(
                  controller: otpController,
                  decoration: const InputDecoration(labelText: "OTP"),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final otp = otpController.text;
                    if (otp.isNotEmpty && verificationId != null) {
                      // Trigger phone number verification event
                      context.read<AuthBloc>().add(
                        VerifyPhoneNumberRequested(
                          verificationId: verificationId!,
                          smsCode: otp,
                        ),
                      );
                    }
                  },
                  child: const Text("Verify OTP"),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
