import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpScreen extends StatefulWidget {

  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  // Number of OTP digits
  static const int _otpLength = 6;

  // Controllers and focus nodes for each digit box
  final List<TextEditingController> _controllers = List.generate(
    _otpLength,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(
    _otpLength,
    (index) => FocusNode(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }

    for (var node in _focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  // Verify OTP function
  void _verifyOtp() {

    String otp = _controllers
        .map((controller) => controller.text)
        .join();

    if (otp.length < _otpLength) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the complete OTP'),
        ),
      );

      return;
    }

    // For now, just show the entered OTP
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('OTP Verified'),
          content: Text('Entered OTP: $otp'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Resend OTP function
  void _resendOtp() {

    for (var controller in _controllers) {
      controller.clear();
    }

    _focusNodes[0].requestFocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('OTP resent to ${widget.email}'),
      ),
    );
  }

  // Builds a single OTP digit box
  Widget _buildOtpBox(int index) {

    return SizedBox(
      width: 48,
      height: 55,

      child: TextFormField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],

        textAlign: TextAlign.center,

        keyboardType: TextInputType.number,

        maxLength: 1,

        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],

        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),

        decoration: InputDecoration(
          counterText: '',

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF064E3B),
              width: 2,
            ),
          ),
        ),

        onChanged: (value) {

          if (value.isNotEmpty && index < _otpLength - 1) {

            _focusNodes[index + 1].requestFocus();
          }

          if (value.isEmpty && index > 0) {

            _focusNodes[index - 1].requestFocus();
          }

          if (value.isNotEmpty && index == _otpLength - 1) {

            _focusNodes[index].unfocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                const SizedBox(height: 50),

                // Back button
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(height: 10),

                // Logo
                const Center(
                  child: Text(
                    'QuickKart',
                    style: TextStyle(
                      color: Color(0xFF064E3B),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 45),

                // Heading
                const Text(
                  'Verify OTP',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Enter the 6-digit code sent to ${widget.email}',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 35),

                // OTP boxes
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: List.generate(
                    _otpLength,
                    (index) => _buildOtpBox(index),
                  ),
                ),

                const SizedBox(height: 35),

                // Verify button
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    onPressed: _verifyOtp,

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF064E3B),

                      foregroundColor: Colors.white,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),

                    child: const Text(
                      'VERIFY',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Resend OTP
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    const Text(
                      "Didn't receive the code? ",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    TextButton(
                      onPressed: _resendOtp,

                      child: const Text(
                        'Resend',
                        style: TextStyle(
                          color: Color(0xFF064E3B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
