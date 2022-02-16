import 'package:flutter/material.dart';
import 'package:lets_accommodate/tenant/categories_tenant.dart';
import 'package:lets_accommodate/tenant/favourite_tenant.dart';
import 'package:lets_accommodate/tenant/settings_tenant.dart';

class IndexView extends StatefulWidget {
  const IndexView({Key? key}) : super(key: key);

  @override
  State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          children: const [
            CategoriesTenant(),
            FavouriteTenant(),
            SettingsTenant(),
          ],
          index: _currentIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            onTap: (int index) {
              setState((() {
                _currentIndex = index;
              }));
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline), label: 'Favourite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ]));
    ;
  }
}
