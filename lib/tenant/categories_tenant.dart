import 'package:flutter/material.dart';
import 'package:lets_accommodate/tenant/single%20room/single_room.dart';

class CategoriesTenant extends StatelessWidget {
  const CategoriesTenant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          Stack(
            alignment: const Alignment(0, 0),
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SingleRoom(
                      category: 'Single Room',
                    );
                  }));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.black,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1589834390005-5d4fb9bf3d32?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80',
                    fit: BoxFit.fill,
                    height: 250,
                    width: double.infinity,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black12,
                ),
                child: const Text(
                  'Single Rooms',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Stack(
            alignment: const Alignment(0, 0),
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SingleRoom(category: 'Chamber and Hall');
                  }));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.black,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1589834390005-5d4fb9bf3d32?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80',
                    fit: BoxFit.fill,
                    height: 250,
                    width: double.infinity,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black12,
                ),
                child: const Text(
                  'Chamber and Hall',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Stack(
            alignment: const Alignment(0, 0),
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SingleRoom(category: 'Two Bedroom');
                  }));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.black,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1589834390005-5d4fb9bf3d32?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80',
                    fit: BoxFit.fill,
                    height: 250,
                    width: double.infinity,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black12,
                ),
                child: const Text(
                  'Two Bedroom',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Stack(
            alignment: const Alignment(0, 0),
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SingleRoom(category: 'Two Bedroom Plus');
                  }));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.black,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1589834390005-5d4fb9bf3d32?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80',
                    fit: BoxFit.fill,
                    height: 250,
                    width: double.infinity,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black12,
                ),
                child: const Text(
                  'Two Bedroom Plus',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
