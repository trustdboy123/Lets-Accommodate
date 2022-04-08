import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_accommodate/auth/login_tenant.dart';
import 'package:lets_accommodate/tenant/categories_tenant.dart';
import 'package:lets_accommodate/tenant/favourite_tenant.dart';
import 'package:lets_accommodate/tenant/settings%20tenant/settings_tenant.dart';

class IndexView extends StatefulWidget {
  const IndexView({Key? key}) : super(key: key);

  @override
  State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  int _currentIndex = 0;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    isUserAuth();
    super.initState();
  }

  isUserAuth() {
    _firebaseAuth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => LoginTenant()), (route) => false);
      }
      if (user != null) {
        print(user.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _firebaseAuth.currentUser == null
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Scaffold(
            body: IndexedStack(
              children: [
                CategoriesTenant(),
                FavouriteTenant(),
                SettingsTenant(),
              ],
              index: _currentIndex,
            ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.blueGrey,
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                onTap: (int index) {
                  setState((() {
                    _currentIndex = index;
                  }));
                },
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.black,
                selectedFontSize: 12.sp,
                unselectedFontSize: 12.sp,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: 'Categories'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'Favourites'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Settings'),
                ]));
  }
}
