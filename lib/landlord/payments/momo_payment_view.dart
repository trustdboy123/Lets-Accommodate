import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Network Provider',
                                style: TextStyle(fontWeight: FontWeight.bold)),
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
                                          child: Text(entry.key),
                                        ))
                                    .toList()),
                          ],
                        ),
                      )),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _numberController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
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
                              backgroundColor: Colors.green),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      )),
    );
  }
}
