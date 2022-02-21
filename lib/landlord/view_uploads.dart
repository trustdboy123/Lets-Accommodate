import 'package:flutter/material.dart';
import 'package:lets_accommodate/landlord/edit_description.dart';

class ViewUploads extends StatelessWidget {
  const ViewUploads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Upload'),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(15),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: ListView.separated(
                  controller: ScrollController(
                      initialScrollOffset: 5, keepScrollOffset: true),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (contex, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      color: Colors.black,
                      child: Image.network(
                        'https://images.unsplash.com/photo-1589834390005-5d4fb9bf3d32?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80',
                        fit: BoxFit.fill,
                        height: 250,
                        width: double.infinity,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 10,
                    );
                  },
                  itemCount: 5),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                const Center(
                  child: Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Single Room',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Type',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Self Contain',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kitchen',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Available',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Washroom',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Available',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Store Room',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Available',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Porch',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Available',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Walled',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'No',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tiled',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Yes',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Electricity',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Available, Shared Meter',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Water',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Available',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '60 Cedis/ month',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Room size',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '3.3ft',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Region',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Eastern',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'City/ Town',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Koforidua',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Digital Address',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'En-207-3724',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'House Number',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'ADW/B76',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const EditDescription();
                      }));
                    },
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text(
                      'Edit Description',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
