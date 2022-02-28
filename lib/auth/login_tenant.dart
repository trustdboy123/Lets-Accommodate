import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lets_accommodate/managers/auth_manager.dart';
import 'package:lets_accommodate/tenant/categories_tenant.dart';
import 'package:lets_accommodate/auth/forgot_password.dart';
import 'package:lets_accommodate/auth/signup_tenant.dart';
import 'package:lets_accommodate/tenant/index_view.dart';

class LoginTenant extends StatefulWidget {
  const LoginTenant({Key? key}) : super(key: key);

  @override
  State<LoginTenant> createState() => _LoginTenantState();
}

class _LoginTenantState extends State<LoginTenant> {
  final AuthManager _authManager = AuthManager();

  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-z]+');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            const SizedBox(
              height: 50,
            ),
            const Center(
              child: Text(
                'Welcome ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                hintText: 'Enter your e-mail',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please enter your full name';
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                hintText: 'Enter your password',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please enter your password';
                }
                if (value.length < 6) {
                  return 'password could not be less than 6 character';
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
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                    textAlign: TextAlign.right,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: _authManager.isLoading
                  ? Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : TextButton(
                      onPressed: () async {
                        if (_globalKey.currentState!.validate()) {
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          setState(() {
                            _isLoading = true;
                          });

                          bool isSuccessful = await _authManager.loginUser(
                              email: email, password: password);
                          if (isSuccessful) {
                            //success
                            Fluttertoast.showToast(
                                msg: " Welcome back to Let's Accomodate",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    Color.fromARGB(255, 94, 196, 97),
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const IndexView()),
                                (route) => false);
                          } else {
                            Fluttertoast.showToast(
                                msg: _authManager.message,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: " Email and Password is required",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color.fromARGB(255, 94, 196, 97),
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      style: TextButton.styleFrom(backgroundColor: Colors.blue),
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
                        color: Colors.blue,
                        fontSize: 15,
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
