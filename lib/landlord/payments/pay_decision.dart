import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_accommodate/auth/decision.dart';
import 'package:lets_accommodate/landlord/payments/add_creditcard.dart';
import 'package:path/path.dart';

import 'momo_payment_view.dart';

class PayDecision extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  double price;
  //double premiumPrice;

  PayDecision({Key? key, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding:
            EdgeInsets.only(top: 20.h, bottom: 10.h, left: 10.w, right: 10.w),
        child: Column(
          // padding:
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Color.fromARGB(255, 103, 116, 184)),
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
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text('/ Month',
                                style: TextStyle(
                                    fontSize: 15.sp, color: Colors.white))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        'Prices are charged based on the category selected',
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: 150.w,
              padding:
                  EdgeInsets.only(top: 15, bottom: 15, right: 20, left: 20),
              decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                  border: Border.all(
                      width: 1.5, color: Color.fromARGB(255, 55, 116, 165))),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Color.fromARGB(255, 109, 116, 135),
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 50.h,
                          child: Column(children: [
                            TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => MomoPaymentView(
                                            price: price,
                                          )));
                                },
                                icon: Icon(
                                  Icons.payments_outlined,
                                  color: Colors.black,
                                ),
                                label: Text(
                                  'Pay with Mobile Money',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.sp),
                                )),
                            // TextButton.icon(
                            //     onPressed: () {},
                            //     icon: Icon(Icons.payment_outlined),
                            //     label: Text(
                            //       'Pay with Card',
                            //       style: TextStyle(
                            //           color: Colors.black,
                            //           fontSize: 12.sp),
                            //     ))
                          ]),
                        );
                      });
                },
                child: Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.black, fontSize: 18.sp),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
