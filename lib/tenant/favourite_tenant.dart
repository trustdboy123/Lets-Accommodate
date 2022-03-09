import 'package:flutter/material.dart';
import 'package:lets_accommodate/tenant/comments_tenants.dart';
import 'package:lets_accommodate/tenant/details.dart';

class FavouriteTenant extends StatelessWidget {
  const FavouriteTenant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                Stack(
                  alignment: const Alignment(-1, -1),
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: (context) {
                        //   return Details();
                        // }));
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '60 cedis/month',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.1, horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star_border_outlined),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return TestMe();
                            }));
                          },
                          icon: Icon(Icons.comment_outlined)),
                      Spacer(),
                      Text('Koforidua, Adweso')
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
