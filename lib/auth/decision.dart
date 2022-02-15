import 'package:flutter/material.dart';
import 'package:lets_accommodate/auth/login_landlord.dart';
import 'package:lets_accommodate/auth/login_tenant.dart';

class Decision extends StatelessWidget {
  const Decision({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Lets get started',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'I am a ...',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const LoginTenant();
                    }));
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text(
                    'Tenant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const LoginLandlord();
                      }));
                    },
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text(
                      'Landlord',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    )),
              ),
              SizedBox(
                height: 100,
              ),
              const Text(
                'Lets accommodate is the best to trust in accommodation',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
