import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_accommodate/managers/post_manager.dart';

class CommentsLandlord extends StatefulWidget {
  const CommentsLandlord({Key? key, required this.docId}) : super(key: key);
  final String docId;
  @override
  _CommentsLandlordState createState() => _CommentsLandlordState();
}

class _CommentsLandlordState extends State<CommentsLandlord> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  final PostManager _postManager = PostManager();
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: StreamBuilder<Map<String, dynamic>?>(
          stream: _postManager.getUserInfo(uid).asStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                snapshot.data == null) {
              return Center(child: CircularProgressIndicator.adaptive());
            }
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data == null) {
              return Center(child: Text('No comment yet'));
            }
            var profilePic = snapshot.data!['profile_pic'];
            return Container(
              child: CommentBox(
                userImage: profilePic,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
                    stream: _postManager.getComments(docId: widget.docId),
                    builder: (context, commentSnapshot) {
                      return ListView.builder(
                          itemCount: commentSnapshot.data == null
                              ? 0
                              : commentSnapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(commentSnapshot
                                      .data!.docs[index]
                                      .data()!['picture'])),
                              title: Text(
                                commentSnapshot.data!.docs[index]
                                    .data()!['name'],
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(commentSnapshot.data!.docs[index]
                                  .data()!['comment']),
                            );
                          }));
                    }),
                labelText: 'Write a comment...',
                withBorder: false,
                errorText: 'Comment cannot be blank',
                sendButtonMethod: () async {
                  if (formKey.currentState!.validate()) {
                    print(commentController.text);
                    bool isSubmited = await _postManager.createComments(
                        comment: commentController.text,
                        profilePic: profilePic,
                        docId: widget.docId,
                        name: snapshot.data!['name']);
                    ;
                    commentController.clear();
                    FocusScope.of(context).unfocus();
                  } else {
                    print("Not validated");
                  }
                },
                formKey: formKey,
                commentController: commentController,
                backgroundColor: Colors.black12,
                textColor: Colors.black,
                sendWidget:
                    Icon(Icons.send_sharp, size: 30, color: Colors.black),
              ),
            );
          }),
    );
  }
}
