import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_accommodate/services/post_manager.dart';

class TestMe extends StatefulWidget {
  const TestMe({Key? key, required this.docId}) : super(key: key);
  final String docId;
  @override
  _TestMeState createState() => _TestMeState();
}

class _TestMeState extends State<TestMe> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  final PostManager _postManager = PostManager();
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  List filedata = [
    {
      'name': 'Adeleye Ayodeji',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to code'
    },
  ];

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: StreamBuilder<Map<String, dynamic>?>(
          stream: _postManager.getTenantInfo(uid).asStream(),
          builder: (context, snapshot) {
            // var profilePic = snapshot.data!['profile_pic'];
            return Container(
              child: CommentBox(
                userImage: '',
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data == null) {
                      return const Center(
                        child: Text('No data available!'),
                      );
                    }
                    return StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
                        stream: _postManager.getComments(docId: widget.docId),
                        builder: (context, userSnapshot) {
                          return ListTile(
                            leading: CircleAvatar(),
                            title:
                                userSnapshot.data!.docs[index].data()!['name'],
                            subtitle: userSnapshot.data!.docs[index]
                                .data()!['comment'],
                          );
                        });
                  }),
                  itemCount: snapshot.data == null ? 0 : snapshot.data!.length,
                ),
                labelText: 'Write a comment...',
                withBorder: false,
                errorText: 'Comment cannot be blank',
                sendButtonMethod: () async {
                  if (formKey.currentState!.validate()) {
                    print(commentController.text);
                    bool isSubmited = await _postManager.createComments(
                      comment: commentController.text,
                      profilePic: 'profilePic',
                      docId: widget.docId,
                    );
                    // setState(() {
                    //   var value = {
                    //     'name': '',
                    //     'pic':
                    //         ' profilePic == null ? CircleAvatar() : profilePic',
                    //     'message': commentController.text
                    //   };
                    //   filedata.insert(0, value);
                    // });
                    commentController.clear();
                    FocusScope.of(context).unfocus();
                  } else {
                    print("Not validated");
                  }
                },
                formKey: formKey,
                commentController: commentController,
                backgroundColor: Colors.black38,
                textColor: Colors.white,
                sendWidget:
                    Icon(Icons.send_sharp, size: 30, color: Colors.white),
              ),
            );
          }),
    );
  }
}
