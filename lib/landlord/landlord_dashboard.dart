import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_accommodate/auth/login_landlord.dart';
import 'package:lets_accommodate/landlord/Settings%20landlord/setting_landlord.dart';
import 'package:lets_accommodate/landlord/add_details_page.dart';
import 'package:lets_accommodate/landlord/comments_landlord.dart';
import 'package:lets_accommodate/landlord/view_uploads.dart';
import 'package:lets_accommodate/managers/post_manager.dart';

class DashboardView extends StatefulWidget {
  DashboardView({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final String userID = FirebaseAuth.instance.currentUser!.uid;

  final PostManager _postManager = PostManager();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    isUserAuth();
    super.initState();
  }

  isUserAuth() {
    _firebaseAuth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => LoginLandlord()),
            (route) => false);
      }
      if (user != null) {
        print(user.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const SettingsLandlord();
                }));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
            stream: _postManager.getAllLandlordRooms(userId: userID),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  snapshot.data == null) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data == null) {
                return const Center(
                    child: Text(
                  'No house added yet',
                  style: TextStyle(color: Colors.black),
                ));
              } else {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    var docID = snapshot.data!.docs[index].id;
                    var intrested =
                        snapshot.data!.docs[index].data()!['interested'];
                    var interestedCount =
                        intrested == null ? 0 : intrested.length;

                    return Card(
                      child: Column(
                        children: [
                          Stack(
                            alignment: const Alignment(-1, -1),
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return ViewUploads(
                                      docId: docID,
                                    );
                                  }));
                                },
                                child: Card(
                                  color: Color(0xFF254AA5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: snapshot.data!.docs.isEmpty
                                      ? const SizedBox(
                                          child: Text('no data yet'),
                                        )
                                      : Image.network(
                                          snapshot.data!.docs[index]
                                              .data()!['pictures'][0],
                                          fit: BoxFit.fitWidth,
                                          height: 250,
                                          width: double.infinity,
                                        ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Colors.black12,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'GHC${snapshot.data!.docs[index].data()!['price']} /month',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.1, horizontal: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star_border_outlined),
                                    Text(interestedCount.toString())
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return CommentsLandlord(
                                          docId: docID,
                                        );
                                      }));
                                    },
                                    icon: Icon(Icons.comment_outlined)),
                                Spacer(),
                                Text(
                                  snapshot.data!.docs[index]
                                      .data()!['city/Town'],
                                  style: TextStyle(fontSize: 12.sp),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount:
                      snapshot.data == null ? 0 : snapshot.data!.docs.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10.h);
                  },
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddImage();
          }));
        },
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
