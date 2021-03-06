import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_accommodate/tenant/single%20room/single_room.dart';

class CategoriesTenant extends StatefulWidget {
  const CategoriesTenant({Key? key}) : super(key: key);

  @override
  State<CategoriesTenant> createState() => _CategoriesTenantState();
}

class _CategoriesTenantState extends State<CategoriesTenant> {
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
                  color: Colors.white,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1560448205-4d9b3e6bb6db?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHJvb218ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                    fit: BoxFit.cover,
                    height: 120.h,
                    width: double.infinity.w,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black12,
                ),
                child: Text(
                  'Single Rooms',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
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
                  color: Colors.white,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                    fit: BoxFit.cover,
                    height: 120.h,
                    width: double.infinity.w,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black12,
                ),
                child: Text(
                  'Chamber and Hall',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
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
                  color: Colors.white,
                  child: Image.network(
                    'https://lh3.googleusercontent.com/IrX8q_pNLb4ZmB4k8X5OOqLlNaXVrrCk4BT1WTaxtjB2mBSLfDQKSbi_-NnuirlA6D0YwfOrHvZlSL_SC1ssut0Uk8WPVxXHfEFzvWEgBWHMv7EIJfcBKzz7NRxdwA=s0',
                    fit: BoxFit.cover,
                    height: 120.h,
                    width: double.infinity.w,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black12,
                ),
                child: Text(
                  'Two Bedroom',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
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
                  color: Colors.white,
                  child: Image.network(
                    'https://sucasapropertiesgh.com/wp-content/uploads/2020/10/1-11.jpg',
                    fit: BoxFit.cover,
                    height: 120.h,
                    width: double.infinity.w,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black12,
                ),
                child: Text(
                  'Two Bedroom Plus',
                  style: TextStyle(
                    fontSize: 20.sp,
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
