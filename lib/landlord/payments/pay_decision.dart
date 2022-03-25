import 'package:flutter/material.dart';
import 'package:lets_accommodate/auth/decision.dart';
import 'package:lets_accommodate/landlord/payments/add_creditcard.dart';

import 'momo_payment_view.dart';

class PayDecision extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  double price;
  var premiumPrice;

  PayDecision({Key? key, required this.price, required this.premiumPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 70,
          ),
          Center(
              child: Text(
            'Select to proceed ',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 150,
                        child: Column(children: [
                          TextButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => MomoPaymentView(
                                          price: price,
                                        )));
                              },
                              icon: Icon(Icons.payments_outlined),
                              label: Text('Pay with Mobile Money')),
                          TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.payment_outlined),
                              label: Text('Pay with Card'))
                        ]),
                      );
                    });
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF254AA5)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          'STANDARD AD',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'GHC $price/ Month',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const Text(
                          'Prices are charged based on categories',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.check,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '1 Upload',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.check),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '1 month advert',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF254AA5)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        'PREMIUM',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'GHC $premiumPrice/ Month',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const Text(
                        'Prices are charged based on categories',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.check,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '1 Upload + 1 upload',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(Icons.check),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '1 month + 15 days advert',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(Icons.check),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Priority assurance',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: SizedBox(
                child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AddCreditcard();
                }));
              },
              child: Text(
                'Proceed',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
            )),
          ),
        ],
      ),
    );
  }
}
