import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthManager with ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  CollectionReference userCollection = _firebaseFirestore.collection('tenants');

  String _message = '';
  bool _isloading = false;

  String get message => _message;
  bool get isLoading => _isloading;

  setMesage(String message) {
    _message = message;
    notifyListeners();
  }

  SetIsLoading(bool message) {
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
    SetIsLoading(true);
    bool isCreated = false;

    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((userCredential) async {
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
    }).catchError((onError) {
      setMesage('$onError');
    }).timeout(const Duration(seconds: 60), onTimeout: () {
      setMesage('Check your internet connection');
      isCreated;
      SetIsLoading(false);
    });
    return isCreated;
  }
}
