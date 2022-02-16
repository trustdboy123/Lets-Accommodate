import 'package:flutter/material.dart';

class LandlordDetails extends StatelessWidget {
  const LandlordDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Landlord Details'),
        ),
        body: ListView(
          children: [CircleAvatar()],
        ));
  }
}
