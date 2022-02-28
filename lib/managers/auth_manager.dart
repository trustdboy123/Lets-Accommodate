import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lets_accommodate/services/file_upload_service.dart';

class AuthManager with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  final FileUploadService _fileUploadService = FileUploadService();

  CollectionReference userCollection = _firebaseFirestore.collection('tenants');
  CollectionReference landlordCollection =
      _firebaseFirestore.collection('landlord');

  String _message = '';
  bool _isloading = false;

  String get message => _message;
  bool get isLoading => _isloading;

  setMesage(String message) {
    _message = message;
    notifyListeners();
  }

  setIsLoading(bool message) {
    _isloading = isLoading;
    notifyListeners();
  }

  Future<bool> createNewUser(
      {required String name,
      required String email,
      required String password,
      required String gender,
      required String location,
      required String number,
      required String nationality}) async {
    setIsLoading(true);
    bool isCreated = false;

    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((userCredential) {
      userCollection.doc(userCredential.user!.uid).set({
        "name": name,
        " email": email,
        "gender": gender,
        "location": location,
        "number": number,
        "nationality": nationality,
        "createdAt": FieldValue.serverTimestamp(),
        "uid": userCredential.user!.uid
      });
      isCreated = true;
    }).catchError((onError) {
      setMesage('$onError');
    }).timeout(const Duration(seconds: 60), onTimeout: () {
      setMesage('Check your internet connection');
      isCreated;
      setIsLoading(false);
    });
    return isCreated;
  }

  Future<bool> loginUser({required email, required password}) async {
    bool isSucessful = false;
    await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((userCredential) {
      if (userCredential.user != null) {
        isSucessful = true;
      }
    }).catchError((onError) {
      setMesage('$onError');
      setIsLoading(false);
    }).timeout(const Duration(seconds: 30), onTimeout: () {
      setMesage('Please Check your internet connection');
      isSucessful = false;
      setIsLoading(false);
    });
    return isSucessful;
  }

  Future<bool> createLandlord(
      {required String name,
      required String email,
      required String password,
      required String gender,
      required String location,
      required String number,
      required String nationality,
      required File imagefile}) async {
    setIsLoading(true);
    bool isCreated = false;

    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((userCredential) async {
      String? photoUrl = await _fileUploadService.uploadFile(
          file: imagefile, uid: userCredential.user!.uid);

      if (photoUrl != null) {
        landlordCollection.doc(userCredential.user!.uid).set({
          "name": name,
          " email": email,
          "gender": gender,
          "location": location,
          "number": number,
          "nationality": nationality,
          "picture": photoUrl,
          "createdAt": FieldValue.serverTimestamp(),
          "uid": userCredential.user!.uid
        });
        isCreated = true;
      } else {
        setMesage('Image Upload falied');
        isCreated = false;
        setIsLoading(false);
      }
      isCreated = true;
    }).catchError((onError) {
      setMesage('$onError');
    }).timeout(const Duration(seconds: 60), onTimeout: () {
      setMesage('Check your internet connection');
      isCreated;
      setIsLoading(false);
    });
    return isCreated;
  }
}
