import 'package:flutter/material.dart';
import 'package:lets_accommodate/landlord/Settings%20landlord/setting_landlord.dart';
import 'package:lets_accommodate/landlord/add_details_page.dart';
import 'package:lets_accommodate/landlord/comments_landlord.dart';
import 'package:lets_accommodate/landlord/view_uploads.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return SettingLandlord();
                }));
              },
              icon: Icon(Icons.settings))
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            Card(
              child: Column(
                children: [
                  Stack(
                    alignment: const Alignment(-1, -1),
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ViewUploads();
                          }));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: Colors.black,
                          child: Image.network(
                            'https://images.unsplash.com/photo-1644941979165-d94993fb9819?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1964&q=80',
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
                            children: const [
                              Text(
                                '60 cedis/month',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.1, horizontal: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star_border_outlined),
                            Text('12')
                          ],
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return CommentsLandlord();
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddImage();
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
