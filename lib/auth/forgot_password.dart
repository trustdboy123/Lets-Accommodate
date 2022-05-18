import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_accommodate/auth/decision.dart';
import 'package:lets_accommodate/auth/login_tenant.dart';

import 'package:lets_accommodate/landlord/landlord_dashboard.dart';
import 'package:lets_accommodate/tenant/categories_tenant.dart';
import 'package:lets_accommodate/auth/signup_landlord.dart';
import 'package:lets_accommodate/managers/auth_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthManager _authManager = AuthManager();
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey();
  bool _isLoading = false;
  final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            SizedBox(
              height: 50.h,
            ),
            Center(
              child: Text(
                'Forgot Password',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Provide your e-mail and we will send you a link to reset your password',
              style: TextStyle(fontSize: 12.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Card(
              shadowColor: Color.fromARGB(255, 86, 79, 81),
              child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: ('E-mail'),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Enter your E-mail',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                  validator: (value) {
                    if (!emailRegExp.hasMatch(value!)) {
                      return 'Enter a valid email!';
                    }

                    if (value.isEmpty) {
                      return 'Please enter an email address';
                    }
                  }),
            ),
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: _authManager.isLoading
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : TextButton(
                      onPressed: () async {
                        if (_globalKey.currentState!.validate()) {
                          String email = _emailController.text.trim();

                          setState(() {
                            _isLoading = true;
                          });
                          bool isSent = await _authManager.sendResetLink(email);
                          if (isSent) {
                            setState(() {
                              _isLoading = false;
                            });
                          }

                          if (isSent) {
                            //succcess
                            Fluttertoast.showToast(
                                msg:
                                    "Reset link sent to your email address, $email",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    Color.fromARGB(255, 116, 117, 116),
                                textColor: Colors.white,
                                fontSize: 16.0);

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Decision()),
                                (route) => false);
                          } else {
                            //failure
                            Fluttertoast.showToast(
                                msg: _authManager.message,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "E-mail is required",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 4, 82, 146)),
                      child: Text(
                        'Send',
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      )),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Go Back',
                  style: TextStyle(
                    color: Color.fromARGB(255, 4, 82, 146),
                    fontSize: 15.sp,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
