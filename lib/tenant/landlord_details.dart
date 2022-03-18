import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_accommodate/managers/post_manager.dart';

class LandlordDetails extends StatelessWidget {
  LandlordDetails({Key? key, required this.userId}) : super(key: key);

  final String userId;

  PostManager _postManager = PostManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Landlord Details'),
        ),
        body: StreamBuilder<Map<String, dynamic>?>(
            stream: _postManager.getUserInfo(userId).asStream(),
            builder: (context, snapshot) {
              print('this is $userId');
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

              return ListView(padding: EdgeInsets.all(8), children: [
                Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0),
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  child: Image.network(
                    snapshot.data!['picture'],
                    fit: BoxFit.fill,
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Full Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          shadowColor: Color(0xFF322E2E),
                          color: Colors.white,
                          child: SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data!['name'],
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Phone Number',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          shadowColor: Color(0xFF322E2E),
                          color: Colors.white,
                          child: SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data!['number'],
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Gender',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          shadowColor: Color(0xFF322E2E),
                          color: Colors.white,
                          child: SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data!['gender'],
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Nationality',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          shadowColor: Color(0xFF322E2E),
                          color: Colors.white,
                          child: SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data!['nationality'],
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ],
                )
              ]);
            }));
  }
}
