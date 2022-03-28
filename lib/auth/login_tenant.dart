import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lets_accommodate/managers/auth_manager.dart';
import 'package:lets_accommodate/auth/forgot_password.dart';
import 'package:lets_accommodate/auth/signup_tenant.dart';
import 'package:lets_accommodate/tenant/categories_tenant.dart';
import 'package:lets_accommodate/tenant/index_view.dart';
import 'package:lets_accommodate/tenant/single%20room/single_room.dart';

class LoginTenant extends StatefulWidget {
  const LoginTenant({Key? key}) : super(key: key);

  @override
  State<LoginTenant> createState() => _LoginTenantState();
}

class _LoginTenantState extends State<LoginTenant> {
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
      body: Stack(children: [
        Form(
          key: _globalKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              const SizedBox(
                height: 50,
              ),
              const Center(
                child: Text(
                  'Welcome',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: 'Enter your e-mail',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                ),
                validator: (value) {
                  if (!emailRegExp.hasMatch(value!)) {
                    return 'Enter a valid email!';
                  }

                  if (value.isEmpty) {
                    return 'Please enter an email address';
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                obscuringCharacter: '*',
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 4, 82, 146),
                  )),
                  hintText: 'Enter your password',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password should not be less than 6 characters';
                  }
                },
              ),
              const SizedBox(
                height: 5,
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
                          color: Color.fromARGB(255, 4, 82, 146), fontSize: 15),
                      textAlign: TextAlign.right,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: _isLoading
                    ? const Center(
                        child: TextButton(
                            onPressed: null,
                            child: CircularProgressIndicator.adaptive()),
                      )
                    : TextButton(
                        onPressed: () async {
                          if (_globalKey.currentState!.validate()) {
                            String email = _emailController.text.trim();
                            String password = _passwordController.text.trim();
                            setState(() {
                              _isLoading = true;
                            });

                            bool isSuccessful = await _authManager.loginUser(
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
                                      builder: (context) => IndexView()),
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
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  const Text(
                    'Dont have an account?',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SignupTenant();
                        }));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color.fromARGB(255, 4, 82, 146),
                          fontSize: 15,
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
