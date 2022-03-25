import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:lets_accommodate/landlord/payments/otp_screen.dart';

// enum WalletProvider {
//   mtn,
//   vod,
//   tgo,
// }

class PaystackProvider {
  // TODO: Insert your heroku url of your paystack backend server here without a trailing slash
  String paystackBackendServerURL =
      "https://lets-accommodate-payment.herokuapp.com";
  final BuildContext context;

  PaystackProvider(this.context);

  payWithMobileMoney({
    required String email,
    required String username,
    required double amountInPesswas,
    required String walletPhoneNumber,
    required String walletProvider,
  }) async {
    Dio dio = Dio();
    try {
      // it makes a post to the paystack backend you deploy to heroku
      var response = await dio.post(
        '$paystackBackendServerURL/payments/charge',
        data: {
          "email": email,
          "amount": amountInPesswas,
          "device_id": username,
          "mobile_money": {
            "phone": walletPhoneNumber,
            "provider": walletProvider
          }
        },
      );

      if (response.statusCode == 200 &&
          response.data["data"]["status"] == "send_otp") {
        print("Charge response: ${response.data}");

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => OtpScreen(
              phoneNumber: walletPhoneNumber,
              reference: response.data["data"]["reference"],
              submitOtp: sendOtpRequest,
            ),
          ),
        );
      }
    } on DioError catch (error) {
      handleError(error);
    }

    dio.close();
  }

  Future<void> sendOtpRequest(
      {required String otp, required String reference}) async {
    print("Sending OTP request: $otp , with reference: $reference");
    Dio dio = Dio();
    try {
      var response = await dio.post(
        '$paystackBackendServerURL/payments/submit-otp',
        data: {
          "otp": otp,
          "reference": reference,
        },
      );
      if (response.statusCode == 200) {
        print("Sent OTP response: ${response.data}");
        // show a toast with `response.data["data"]["display_text"]`
      }
    } on DioError catch (error) {
      handleError(error);
    }
    dio.close();
  }

  payWithCreditCard({
    required PaystackPlugin paystackPlugin,
    required BuildContext context,
    amount,
    email,
  }) async {
    Dio dio = Dio();
    try {
      var response = await dio.post(
          '$paystackBackendServerURL/payments/generate-access-token',
          data: {
            "email": email,
            "amount": amount,
          });
      if (response.statusCode == 200) {
        print("Access Code response: ${response.data["data"]["access_code"]}");

        Charge charge = Charge()
          ..email = email
          ..amount = 1 * 100
          ..currency = "GHS"
          ..accessCode = response.data["data"]["access_code"];
        // ..reference = _getReference() //TODO: Get access_token from backend
        CheckoutResponse checkoutResponse = await paystackPlugin.checkout(
          context,
          charge: charge,
          method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
        );
        print(checkoutResponse);
      }
    } on DioError catch (error) {
      handleError(error);
    }
    dio.close();
  }

  /// prints and toast an error
  void handleError(DioError error) {
    if (error.response != null) {
      print(error);
      print(error.response?.data);
    } else {
      print(error.message);
    }
  }
}
