import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_accommodate/landlord/landlord_dashboard.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({
    Key? key,
    required this.phoneNumber,
    required this.reference,
    required this.submitOtp,
  }) : super(key: key);

  final String phoneNumber;
  final String reference;
  final Future<void> Function({required String otp, required String reference})
      submitOtp;
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinOtpCodeFocus = FocusNode();
  final BoxDecoration pinOtpCodeDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Text(
                  "An OTP code was sent to $phoneNumber. Enter it here to authorize the transction"),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Pinput(
                  length: 6,
                  focusNode: _pinOtpCodeFocus,
                  controller: _pinController,
                  submittedPinTheme: PinTheme(
                      height: 50, width: 40, decoration: pinOtpCodeDecoration),
                  focusedPinTheme: PinTheme(
                      height: 50, width: 40, decoration: pinOtpCodeDecoration),
                  followingPinTheme: PinTheme(
                      height: 50, width: 40, decoration: pinOtpCodeDecoration),
                  pinAnimationType: PinAnimationType.rotation,
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: double.infinity,
                height: 30.h,
                child: TextButton(
                  onPressed: () async {
                    await submitOtp(
                        otp: _pinController.text, reference: reference);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => DashboardView()),
                        (route) => false);
                  },
                  child: Text(
                    'Verify..',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 4, 82, 146)),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop;
                  },
                  child: Text(
                    'Go back',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Color.fromARGB(255, 4, 82, 146)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
