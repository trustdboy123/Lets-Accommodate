import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_accommodate/services/post_manager.dart';
import 'package:lets_accommodate/tenant/details.dart';
import 'package:lets_accommodate/tenant/comments_tenants.dart';

class SingleRoom extends StatelessWidget {
  SingleRoom({Key? key}) : super(key: key);
  final PostManager _postManager = PostManager();
  TextEditingController? _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Single Rooms'),
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
          stream: _postManager.getSingleRooms(),
          builder: (context, snapshot) {
            return ListView.separated(
                itemBuilder: (context, index) {
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
                  return Card(
                      child: Column(
                    children: [
                      Stack(
                        alignment: const Alignment(-1, -1),
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Details();
                              }));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              color: Colors.black,
                              child: Image.network(
                                snapshot.data!.docs[index].data()!['picture'],
                                fit: BoxFit.fill,
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
                                    snapshot.data!.docs[index]
                                        .data()!['price']!,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.favorite_border_rounded,
                                        color: Colors.white,
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
                                Text('12')
                              ],
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return TestMe();
                                  }));
                                },
                                icon: Icon(Icons.comment_outlined)),
                            Spacer(),
                            Text(snapshot.data!.docs[index]
                                .data()!['city/town']!)
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
