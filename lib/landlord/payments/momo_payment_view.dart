import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_accommodate/landlord/payments/paystack_provider.dart';
import 'package:lets_accommodate/managers/post_manager.dart';

class MomoPaymentView extends StatefulWidget {
  final double price;
  const MomoPaymentView({Key? key, required this.price}) : super(key: key);

  @override
  State<MomoPaymentView> createState() => _MomoPaymentViewState();
}

class _MomoPaymentViewState extends State<MomoPaymentView> {
  String networkProvider = 'mtn';
  final TextEditingController _numberController = TextEditingController();
  //final PaystackProvider _paystackProvider = PaystackProvider();

  String uid = FirebaseAuth.instance.currentUser!.uid;
  final PostManager _postManager = PostManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Momo Payment'),
      ),
      body: SafeArea(
          child: Form(
        child: StreamBuilder<Map<String, dynamic>?>(
            stream: _postManager.getUserInfo(uid).asStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data == null) {
                return const Center(
                  child: Text('No data is available'),
                );
              }
              String username = snapshot.data!['name'];
              String email = snapshot.data!['email'];
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Network Provider',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp)),
                            DropdownButtonFormField(
                                value: networkProvider,
                                icon: const Icon(Icons.arrow_drop_down),
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    networkProvider = newValue!;
                                  });
                                },
                                items: {
                                  'MTN Momo': 'mtn',
                                  'VodaCash': 'vod',
                                  'AirtelTigo Cash': 'tgo',
                                }
                                    .entries
                                    .map((entry) => DropdownMenuItem(
                                          value: entry.value,
                                          child: Text(
                                            entry.key,
                                            style: TextStyle(fontSize: 13.sp),
                                          ),
                                        ))
                                    .toList()),
                          ],
                        ),
                      )),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _numberController,
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              hintText: 'Enter mobile money number',
                              hintStyle: TextStyle(fontSize: 12.sp),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextButton.icon(
                          onPressed: () async {
                            double amount = widget.price;
                            print(email);
                            print(username);
                            print(networkProvider);
                            print(_numberController.text);
                            await PaystackProvider(context).payWithMobileMoney(
                              email: email,
                              username: username,
                              amountInPesswas: amount * 100,
                              walletPhoneNumber: _numberController.text.trim(),
                              walletProvider: networkProvider,
                            );
                          },
                          icon: Icon(
                            Icons.security,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Pay',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 59, 112, 155)),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'To make payments with Vodafone Cash',
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Follow the steps below:',
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w600),
                          ),
                          Text('1. Dial *110#',
                              style: TextStyle(fontSize: 12.sp)),
                          Text('2. Select option 4 "make payment"',
                              style: TextStyle(fontSize: 12.sp)),
                          Text('3. Select option 4 "Generate voucher"',
                              style: TextStyle(fontSize: 12.sp)),
                          Text('4. Enter pin',
                              style: TextStyle(fontSize: 12.sp)),
                          Text('5. Press Pay to proceed',
                              style: TextStyle(fontSize: 12.sp)),
                          Text('6. Enter generated voucher to make payment',
                              style: TextStyle(fontSize: 12.sp)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      )),
    );
  }
}
