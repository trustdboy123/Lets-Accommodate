import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lets_accommodate/landlord/add_details_page.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 17),
          children: const [
            Text(
              "Hello George",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4),
            Text(
              "Let's get started with uploads",
              style: TextStyle(
                fontSize: 10,
              ),
            ),
            Center(
                heightFactor: 20,
                child: Text("You have not uploaded any buildings yet"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddDetailsView();
          }));
        },
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
