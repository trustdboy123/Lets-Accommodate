import 'package:flutter/material.dart';
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
        child: Column(
          children: [
            Text(
                "An OTP code was sent to $phoneNumber. Enter it here to authorize the transction"),

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
                onSubmitted: (pin) async {
                  await submitOtp(otp: pin, reference: reference);
                  
                  
                  // so when the onSubmitted is called we call the submitOtp function 
                  //which is a parameter we passed from the paystack provider when we navigated to the otp screen
                  // we only passed the fucntion there as a parameter, and didn't execute it, 
                  // so here is where we execute it passing in the otp that was just entered and the reference passed in when we navigated to this screen
                  // makes sense???
                  //sure it does.
                  //the running is complete and when i tried i got
                  //DioError [DioErrorType.response]: Http status error [400]
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
