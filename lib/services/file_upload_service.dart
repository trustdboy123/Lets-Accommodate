import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class FileUploadService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadFile({required File file, required String uid}) async {
    try {
      Reference storageRef =
          _firebaseStorage.ref().child('profile_pictures').child('$uid.jpg');
      UploadTask storageUploadTask = storageRef.putFile(file);

      TaskSnapshot snapshot = await storageUploadTask
          .whenComplete(() => storageRef.getDownloadURL());

      return await snapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print('##### $e');
      return null;
    }
  }

  Future<String?> uploadPostFile({required List<File> file}) async {
    //  int i = 1;

    // for (var img in file) {

    //   String fileName = Path.basename(img.path);
    //     Reference storageRef =
    //       _firebaseStorage.ref().child('post_images').child(fileName);

    //   await storageRef.putFile(img).whenComplete(() async {
    //     await storageRef.getDownloadURL().then((value) {
    //       'post_images'.add({'url': value});
    //       i++;
    //     });
    //   });
    // }
    try {
      for (var img in file) {
        String fileName = Path.basename(img.path);
        Reference storageRef =
            _firebaseStorage.ref().child('post_images').child(fileName);

        UploadTask storageUploadTask = storageRef.putFile(img);

        TaskSnapshot snapshot = await storageUploadTask
            .whenComplete(() => storageRef.getDownloadURL());

        return await snapshot.ref.getDownloadURL().then((value) {});
      }
    } on FirebaseException catch (e) {
      print('####### $e');
      return null;
    }
  }

  // Future<List<String>> uploadFiles(List<File> _images) async {
  //   var imageUrls =
  //       await Future.wait(_images.map((_image) => uploadPic(_image)));
  //   return imageUrls;
  // }

  // Future<String> uploadPic(File _image) async {
  //   Reference storageReference =
  //       _firebaseStorage.ref().child('posts').child(_image.path);
  //   UploadTask uploadTask = storageReference.putFile(_image);
  //   TaskSnapshot snapshot =
  //       await uploadTask.whenComplete(() => storageReference.getDownloadURL());
  //   return await snapshot.ref.getDownloadURL();
  // }
}
