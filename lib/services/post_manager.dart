import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_accommodate/services/file_upload_service.dart';

class PostManager with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  final FileUploadService _fileUploadService = FileUploadService();

  final CollectionReference<Map<String, dynamic>> _landlordCollection =
      _firebaseFirestore.collection("landlord");
  final CollectionReference<Map<String, dynamic>> _uploadsCollection =
      _firebaseFirestore.collection('uploads');

  String _message = '';
  bool _isLoading = false;
  String get message => _message;
  bool get isLoading => _isLoading;

  SetMessage(String message) {
    _message = message;
    notifyListeners();

    setIsLoading(bool loading) {
      _isLoading = isLoading;
      notifyListeners();
    }
  }

  Future<bool> submitPost(
      {required List<File> postImage,
      required String category,
      required String type,
      String? kitchen,
      String? washroom,
      String? storeRoom,
      String? walledHouse,
      String? tiled,
      String? porch,
      required String electricity,
      required String waterAvailability,
      required String price,
      required String size,
      required String region,
      required String citytown,
      String? digitalAddress,
      required String houseNumber}) async {
    bool isSubmited = false;
    String userUid = _firebaseAuth.currentUser!.uid;
    FieldValue timestamp = FieldValue.serverTimestamp();
    String? photoUrl = await _fileUploadService.uploadPostFile(file: postImage);

    if (photoUrl != null) {
      await _uploadsCollection.doc().set({
        "category": category,
        "type": type,
        "kitchen": kitchen,
        "washroom": washroom,
        "store Room": storeRoom,
        "walled House": walledHouse,
        "tiled": tiled,
        "electricity": electricity,
        "water Availability": waterAvailability,
        "price": price,
        "size": size,
        "region": region,
        "city/Town": citytown,
        "digital Address": digitalAddress,
        "house Number": houseNumber,
        "picture": photoUrl,
        "createdAt": timestamp,
        "user_id": userUid
      }).then((_) {
        isSubmited = true;
        SetMessage('Post successfully submited');
      }).catchError((onError) {
        isSubmited = false;
        SetMessage('### $onError');
      }).timeout(const Duration(seconds: 60), onTimeout: () {
        isSubmited = false;
        SetMessage('Please Check your connection');
      });
    } else {
      isSubmited = false;
      SetMessage('Image not found');
    }
    return isSubmited;
  }

  Stream<QuerySnapshot<Map<String, dynamic>?>> getSingleRooms() {
    return _uploadsCollection
        .where('category', isEqualTo: 'Single Room')
        .snapshots();
  }
}
