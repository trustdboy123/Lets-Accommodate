import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

              return ListView(padding: EdgeInsets.all(16), children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  child: Image.network(
                    snapshot.data!['picture'],
                    fit: BoxFit.fill,
                    height: 150.h,
                    width: MediaQuery.of(context).size.width.w,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Card(
                  color: Color.fromARGB(255, 233, 230, 230),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Full Name',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Card(
                            shadowColor: Color(0xFF322E2E),
                            color: Colors.white,
                            child: SizedBox(
                              height: 20.h,
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
                            height: 5.h,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Phone Number',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Card(
                            shadowColor: Color(0xFF322E2E),
                            color: Colors.white,
                            child: SizedBox(
                              height: 20.h,
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
                          SizedBox(
                            height: 5.h,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Gender',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
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
                            height: 5.h,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Nationality',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
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
                            height: 10.h,
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ]);
            }));
  }
}
