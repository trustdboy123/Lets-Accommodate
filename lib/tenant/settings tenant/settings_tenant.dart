import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_accommodate/managers/post_manager.dart';
import 'package:lets_accommodate/tenant/settings%20tenant/edit_profile_tenant.dart';
import 'package:path/path.dart';

class SettingsTenant extends StatefulWidget {
  const SettingsTenant({Key? key}) : super(key: key);

  @override
  State<SettingsTenant> createState() => _SettingsTenantState();
}

class _SettingsTenantState extends State<SettingsTenant> {
  String dropdownValuemail = '';
  PostManager _postManager = PostManager();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<Map<String, dynamic>?>(
              stream: _postManager.getTenantInfo(uid).asStream(),
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
                return ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (Context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Image.network(
                                          snapshot.data!['profile_pic']),
                                    ),
                                  );
                                });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage:
                                NetworkImage(snapshot.data!['profile_pic']),
                            radius: 100.r,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return EditProfileTenant();
                                }));
                              },
                              child: Text(
                                'Edit profile',
                                style: TextStyle(fontSize: 12.sp),
                              )),
                        ),
                        Text(
                          snapshot.data!['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 25.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ListView(
                                padding: EdgeInsets.all(16),
                                children: [
                                  const Icon(
                                    Icons.email,
                                    size: 80,
                                    color: Colors.lightBlue,
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        'Email: letsaccommodateof4@gmail.com',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.facebook_rounded,
                                    size: 80,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        'Facebook: Letsaccommodate Mobile app',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Card(
                        color: Color.fromARGB(255, 233, 230, 230),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Text(
                                'Need help',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Icon(
                                Icons.help,
                                color: Colors.black,
                              ),
                              Text(
                                'Contact Us',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Card(
                      child: TextButton(
                          onPressed: () async {
                            _firebaseAuth.signOut();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.settings_power,
                                color: Colors.red,
                              ),
                              Text(
                                'logout',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.sp),
                              ),
                            ],
                          )),
                    )
                  ],
                );
              }),
        ));
  }
}
