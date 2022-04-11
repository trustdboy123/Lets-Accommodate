import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_accommodate/auth/decision.dart';
import 'package:lets_accommodate/landlord/payments/add_creditcard.dart';
import 'package:path/path.dart';

import 'momo_payment_view.dart';

class PayDecision extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  double price;
  double premiumPrice;

  PayDecision({Key? key, required this.price, required this.premiumPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Go Back',
                      style: TextStyle(
                          color: Color.fromARGB(255, 4, 82, 146),
                          fontSize: 14.sp),
                    )),
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  'SELECT TO PROCEED ',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 20.sp),
                ),
              ],
            ),
          )),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 69, 80, 142)),
                child: Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    child: Column(
                      children: [
                        Text(
                          'STANDARD AD',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 253, 254, 254)),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.r)),
                              border: Border.all(color: Colors.black)),
                          padding: EdgeInsets.only(
                              top: 5.h, bottom: 5.h, right: 10.h, left: 10.h),
                          child: Column(
                            children: [
                              Text(
                                'GHC $price',
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text('/ Month',
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.black))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          'Prices are charged based on the category selected',
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check,
                              color: Color.fromARGB(255, 248, 249, 249),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              '1 Upload',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check,
                              color: Color.fromARGB(255, 250, 251, 252),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              '1 month advertisement',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, right: 20, left: 20),
                          decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.r)),
                              border:
                                  Border.all(width: 1.5, color: Colors.white)),
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  backgroundColor:
                                      Color.fromARGB(255, 109, 116, 135),
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: 70.h,
                                      child: Column(children: [
                                        TextButton.icon(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          MomoPaymentView(
                                                            price: price,
                                                          )));
                                            },
                                            icon: Icon(Icons.payments_outlined),
                                            label: Text(
                                              'Pay with Mobile Money',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.sp),
                                            )),
                                        TextButton.icon(
                                            onPressed: () {},
                                            icon: Icon(Icons.payment_outlined),
                                            label: Text(
                                              'Pay with Card',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.sp),
                                            ))
                                      ]),
                                    );
                                  });
                            },
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.sp),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}
