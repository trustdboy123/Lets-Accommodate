import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_accommodate/auth/forgot_password.dart';

import 'package:lets_accommodate/landlord/landlord_dashboard.dart';
import 'package:lets_accommodate/tenant/categories_tenant.dart';
import 'package:lets_accommodate/auth/signup_landlord.dart';
import 'package:lets_accommodate/managers/auth_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginLandlord extends StatefulWidget {
  const LoginLandlord({Key? key}) : super(key: key);

  @override
  State<LoginLandlord> createState() => _LoginLandlordState();
}

class _LoginLandlordState extends State<LoginLandlord> {
  final AuthManager _authManager = AuthManager();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                'Welcome',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: ('E-mail'),
                  labelStyle: TextStyle(fontSize: 12.sp),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: 'Enter your E-mail',
                  hintStyle: TextStyle(fontSize: 12.sp),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
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
            SizedBox(
              height: 10.h,
            ),
            TextFormField(
                controller: _passwordController,
                obscureText: true,
                obscuringCharacter: '*',
                keyboardType: TextInputType.visiblePassword,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: ('Password'),
                  labelStyle: TextStyle(fontSize: 12.sp),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(fontSize: 12.sp),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a valid email!';
                  }

                  if (value.length < 6) {
                    return 'Password should not be less than 6 characters';
                  }
                }),
            SizedBox(
              height: 5.h,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const ForgotPassword();
                    }));
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                        color: Color.fromARGB(255, 4, 82, 146),
                        fontSize: 12.sp),
                    textAlign: TextAlign.right,
                  )),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: _authManager.isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : TextButton(
                      onPressed: () async {
                        if (_globalKey.currentState!.validate()) {
                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();
                          setState(() {
                            _isLoading = true;
                          });

                          bool isSuccessful = await _authManager.loginLandlord(
                              email: email, password: password);
                          if (isSuccessful) {
                            //succcess
                            Fluttertoast.showToast(
                                msg: "Welcome back to Lets Accommodate",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    Color.fromARGB(255, 94, 196, 97),
                                textColor: Colors.white,
                                fontSize: 16.0);

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => DashboardView()),
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
                              msg: "Email and password is required!",
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
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      )),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Text(
                  'Dont have an account?',
                  style: TextStyle(fontSize: 12.sp, color: Colors.black),
                ),
                SizedBox(
                  width: 5.w,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) {
                        return const SignupLandlord();
                      }), (route) => false);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color.fromARGB(255, 4, 82, 146),
                        fontSize: 12.sp,
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
