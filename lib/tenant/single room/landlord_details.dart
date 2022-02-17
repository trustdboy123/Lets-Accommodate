import 'package:flutter/material.dart';

class LandlordDetails extends StatelessWidget {
  const LandlordDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Landlord Details'),
        ),
        body: ListView(padding: EdgeInsets.all(8), children: [
          Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 0),
                borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            child: Image.network(
              'https://images.unsplash.com/photo-1589834390005-5d4fb9bf3d32?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80',
              fit: BoxFit.fill,
              height: 250,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // ignore: avoid_unnecessary_containers
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Full Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Card(
                    shadowColor: Color(0xFF322E2E),
                    color: Colors.white,
                    child: SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'George Amankwa',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Phone Number',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Card(
                    shadowColor: Color(0xFF322E2E),
                    color: Colors.white,
                    child: SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '0247890234',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Gender',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Card(
                    shadowColor: Color(0xFF322E2E),
                    color: Colors.white,
                    child: SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Male',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Nationality',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Card(
                    shadowColor: Color(0xFF322E2E),
                    color: Colors.white,
                    child: SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'George Amankwa',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ],
          )
        ]));
  }
}
