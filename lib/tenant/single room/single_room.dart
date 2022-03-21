import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_accommodate/managers/post_manager.dart';
import 'package:lets_accommodate/tenant/details.dart';
import 'package:lets_accommodate/tenant/comments_tenants.dart';

class SingleRoom extends StatefulWidget {
  final String category;

  SingleRoom({required this.category});

  @override
  State<SingleRoom> createState() => _SingleRoomState();
}

class _SingleRoomState extends State<SingleRoom> {
  // SingleRoom({Key? key}) : super(key: key);
  final PostManager _postManager = PostManager();

  String uid = FirebaseAuth.instance.currentUser!.uid;

  final TextEditingController? _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.category),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  onChanged: (value) {},
                  controller: _textEditingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          )),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
          stream: _postManager.getSingleRooms(category: widget.category),
          builder: (context, snapshot) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  var docId = snapshot.data!.docs[index].id;
                  var intrested =
                      snapshot.data!.docs[index].data()!['interested'];
                  var interestedCount = intrested.length;
                  var favorites =
                      snapshot.data!.docs[index].data()!['favorites'];
                  bool isSelected = (favorites[uid] == true);
                  //var userId = snapshot.data!.docs[index].data()!['user_id'];
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data == null) {
                    return const Center(
                      child: Text(
                        'No data is available',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }
                  return Card(
                      child: Column(
                    children: [
                      Stack(
                        alignment: const Alignment(-1, -1),
                        children: [
                          InkWell(
                            onTap: () async {
                              print('***$docId');

                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Details(
                                  docId: docId,
                                );
                              }));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              color: Colors.black,
                              child: Image.network(
                                snapshot.data!.docs[index].data()!['pictures']
                                    [0],
                                fit: BoxFit.cover,
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
                                    "GHC${snapshot.data!.docs[index].data()!['price']} /Month",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        bool isFavorite =
                                            favorites[uid] == false;
                                        if (isFavorite) {
                                          await _postManager.handleFavorites(
                                              docId: docId, favorite: true);
                                          setState(() {
                                            isSelected = true;
                                            favorites[uid] = true;
                                          });
                                        } else if (!isFavorite) {
                                          await _postManager.handleFavorites(
                                              docId: docId, favorite: false);
                                          setState(() {
                                            isSelected = false;
                                            favorites[uid] = false;
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        isSelected
                                            ? Icons.favorite
                                            : Icons.favorite_border_rounded,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0.1, horizontal: 20),
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
                                    return TestMe(
                                      docId: docId,
                                    );
                                  }));
                                },
                                icon: Icon(Icons.comment_outlined)),
                            Spacer(),
                            Text(
                                snapshot.data!.docs[index].data()!['city/Town'])
                          ],
                        ),
                      )
                    ],
                  ));
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
                itemCount:
                    snapshot.data == null ? 0 : snapshot.data!.docs.length);
          }),
    );
  }
}
