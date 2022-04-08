import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_accommodate/auth/login_landlord.dart';
import 'package:lets_accommodate/auth/login_tenant.dart';

class Decision extends StatelessWidget {
  const Decision({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // SizedBox(
        //   child: Image(
        //     image: AssetImage('assets/background.png'),
        //     fit: BoxFit.cover,
        //   ),
        //   height: double.infinity,
        //   width: double.infinity,
        // ),
        Center(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              SizedBox(
                height: 80.h,
              ),
              Text(
                'Let\'s get started',
                style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'I\'m a ...',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                height: 30.h,
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
                  child: Text(
                    'Tenant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 30.h,
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
                      style: TextStyle(color: Colors.white, fontSize: 25.sp),
                    )),
              ),
              SizedBox(
                height: 70.h,
              ),
              Column(
                children: [
                  Text(
                    'Rent a house in your comfort zone',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Powered by DeCoders',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
