import 'package:flutter/material.dart';
import 'package:lets_accommodate/auth/login_landlord.dart';
import 'package:lets_accommodate/auth/login_tenant.dart';

class Decision extends StatelessWidget {
  const Decision({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          child: Image(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
          height: double.infinity,
          width: double.infinity,
        ),
        Center(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Let\'s get started',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'I\'m a ...',
                style: TextStyle(
                  color: Colors.white,
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
                  style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 4, 82, 146)),
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
              Card(
                elevation: 10,
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const LoginLandlord();
                        }));
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 4, 82, 146)),
                      child: Text(
                        'Landlord',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              const Text(
                'Let\'s accommodate is the best to trust in accommodation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ]),
    );
  }
}
