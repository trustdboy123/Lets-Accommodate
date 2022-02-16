import 'package:flutter/material.dart';
import 'package:lets_accommodate/tenant/categories_tenant.dart';
import 'package:lets_accommodate/auth/forgot_password.dart';
import 'package:lets_accommodate/auth/signup_tenant.dart';
import 'package:lets_accommodate/tenant/index_view.dart';

class LoginTenant extends StatelessWidget {
  const LoginTenant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
            height: 30,
          ),
          const Text(
            'E-mail',
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            child: Form(
              child: TextFormField(
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  label: Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: 'Enter your e-mail',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text('Password',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600)),
          SizedBox(
            height: 5,
          ),
          Card(
            child: Form(
              child: TextFormField(
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  label: Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: 'Enter your password',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
              ),
            ),
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
            child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const IndexView();
                  }));
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
    );
  }
}
