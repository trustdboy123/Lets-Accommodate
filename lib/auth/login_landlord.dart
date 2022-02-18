import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:lets_accommodate/landlord/home_landlord.dart';
=======
import 'package:lets_accommodate/landlord/categories_landlord.dart';
import 'package:lets_accommodate/landlord/landlord_dashboard.dart';
>>>>>>> 86edeac295aae48cd7564a3734f0d9df13b9b8f9
import 'package:lets_accommodate/tenant/categories_tenant.dart';
import 'package:lets_accommodate/auth/signup_landlord.dart';

class LoginLandlord extends StatelessWidget {
  const LoginLandlord({Key? key}) : super(key: key);

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
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
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
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
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
                    return const LoginLandlord();
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
<<<<<<< HEAD
                    return const HomeLandlord();
=======
                    return const DashboardView();
>>>>>>> 86edeac295aae48cd7564a3734f0d9df13b9b8f9
                  }));
                },
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Text(
                'Dont have an account?',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              SizedBox(
                width: 5,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const SignupLandlord();
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
