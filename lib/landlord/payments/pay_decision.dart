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
            height: 40.h,
          ),
          Center(
              child: Text(
            'Select to proceed ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20.sp),
          )),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Color.fromARGB(255, 185, 193, 214),
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 70.h,
                          child: Column(children: [
                            TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => MomoPaymentView(
                                            price: price,
                                          )));
                                },
                                icon: Icon(Icons.payments_outlined),
                                label: Text(
                                  'Pay with Mobile Money',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12.sp),
                                )),
                            TextButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.payment_outlined),
                                label: Text(
                                  'Pay with Card',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12.sp),
                                ))
                          ]),
                        );
                      });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 69, 80, 142)),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 20.w),
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
                            padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                            color: Colors.white,
                            height: 40.h,
                            width: 200.w,
                            child: Column(
                              children: [
                                Text(
                                  'GHC $price',
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text('per month',
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
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            height: 20.h, width: 100.w,
                            decoration: BoxDecoration(color: Colors.white),

                            // padding: EdgeInsets.symmetric(
                            // vertical: 10.h, horizontal: 20.w),
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.sp),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Card(
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: GestureDetector(
          //         onTap: () {
          //           showModalBottomSheet(
          //               backgroundColor: Color.fromARGB(255, 185, 193, 214),
          //               context: context,
          //               builder: (context) {
          //                 return SizedBox(
          //                   height: 70.h,
          //                   child: Column(children: [
          //                     TextButton.icon(
          //                         onPressed: () {
          //                           Navigator.of(context).pop();
          //                           Navigator.of(context)
          //                               .push(MaterialPageRoute(
          //                                   builder: (_) => MomoPaymentView(
          //                                         price: price,
          //                                       )));
          //                         },
          //                         icon: Icon(Icons.payments_outlined),
          //                         label: Text(
          //                           'Pay with Mobile Money',
          //                           style: TextStyle(
          //                               color: Colors.black, fontSize: 12.sp),
          //                         )),
          //                     TextButton.icon(
          //                         onPressed: () {},
          //                         icon: Icon(Icons.payment_outlined),
          //                         label: Text(
          //                           'Pay with Card',
          //                           style: TextStyle(
          //                               color: Colors.black, fontSize: 12.sp),
          //                         ))
          //                   ]),
          //                 );
          //               });
          //         },
          //         child: Container(
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(20),
          //               color: Color(0xFF254AA5)),
          //           child: Center(
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Column(
          //                 children: [
          //                   const Text(
          //                     'PREMIUM',
          //                     style: TextStyle(
          //                         fontSize: 15,
          //                         fontWeight: FontWeight.w600,
          //                         color: Colors.white),
          //                   ),
          //                   SizedBox(
          //                     height: 10.h,
          //                   ),
          //                   Text(
          //                     'GHC $premiumPrice/ Month',
          //                     style: TextStyle(
          //                         fontSize: 20,
          //                         fontWeight: FontWeight.bold,
          //                         color: Colors.white),
          //                   ),
          //                   const Text(
          //                     'Prices are charged based on categories',
          //                     style: TextStyle(color: Colors.white),
          //                   ),
          //                   SizedBox(
          //                     height: 10.h,
          //                   ),
          //                   Row(
          //                     children: [
          //                       const Icon(
          //                         Icons.check,
          //                         color: Colors.white,
          //                       ),
          //                       SizedBox(
          //                         width: 10.w,
          //                       ),
          //                       Text(
          //                         '1 Upload + 1 upload',
          //                         style: TextStyle(color: Colors.white),
          //                       ),
          //                     ],
          //                   ),
          //                   SizedBox(
          //                     height: 5.h,
          //                   ),
          //                   Row(
          //                     children: [
          //                       const Icon(
          //                         Icons.check,
          //                         color: Colors.white,
          //                       ),
          //                       SizedBox(
          //                         width: 5.w,
          //                       ),
          //                       Text(
          //                         '1 month + 15 days advert',
          //                         style: TextStyle(color: Colors.white),
          //                       ),
          //                     ],
          //                   ),
          //                   SizedBox(
          //                     height: 5.h,
          //                   ),
          //                   Row(
          //                     children: [
          //                       Icon(
          //                         Icons.check,
          //                         color: Colors.white,
          //                       ),
          //                       SizedBox(
          //                         width: 5.w,
          //                       ),
          //                       Text(
          //                         'Priority assurance',
          //                         style: TextStyle(color: Colors.white),
          //                       ),
          //                     ],
          //                   ),
          //                   SizedBox(
          //                     height: 10.h,
          //                   )
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
