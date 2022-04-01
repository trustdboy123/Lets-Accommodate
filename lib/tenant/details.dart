import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_accommodate/managers/post_manager.dart';
import 'package:lets_accommodate/tenant/landlord_details.dart';

class Details extends StatefulWidget {
  const Details({Key? key, required this.docId}) : super(key: key);
  final String docId;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final PostManager _postManager = PostManager();
  final PageController _pageController = PageController();
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  bool isSelected = false;
  var _currentPageValue = 0.0;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>?>>(
            stream: _postManager.getRoomDetails(docID: widget.docId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data == null) {
                return const Center(
                  child: Text('No data is available'),
                );
              }
              var userId = snapshot.data!.data()!['user_id'];
              var pictures = snapshot.data!.data()!['pictures'];
              var intrested = snapshot.data!.data()!['interested'];
              var interestedCount = intrested.length;

              return SingleChildScrollView(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                        height: 180.h,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: pictures.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width.w,
                              height: 240.h,
                              child: Container(
                                width: MediaQuery.of(context).size.width.w,
                                height: 200,
                                color: Colors.black,
                                child: Image.network(
                                  pictures[index],
                                  fit: BoxFit.fill,
                                  height: 250,
                                  width: double.infinity.w,
                                ),
                              ),
                            );
                          },
                        )),
                    DotsIndicator(
                      dotsCount: pictures.length,
                      position: _currentPageValue,
                      decorator: DotsDecorator(
                          color: Colors.black87,
                          activeColor: Color.fromARGB(255, 17, 72, 167),
                          activeSize: Size(18.0, 9.0),
                          size: Size.square(9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              'Description',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Categories',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                snapshot.data!.data()!['category'],
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Type',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                snapshot.data!.data()!['type'],
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Kitchen',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                snapshot.data!.data()!['kitchen'],
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Washroom',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                snapshot.data!.data()!['washroom'],
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Store Room',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                snapshot.data!.data()!['store Room'],
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Porch',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                snapshot.data!.data()!['porch'],
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Walled',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                snapshot.data!.data()!['walled House'],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tiled',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                snapshot.data!.data()!['tiled'],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Electricity',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                snapshot.data!.data()!['electricity'],
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Water',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                snapshot.data!.data()!['water Availability'],
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Price',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                '${snapshot.data!.data()!['price']} /month',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Room size',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                snapshot.data!.data()!['size'],
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Region',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                snapshot.data!.data()!['region'],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'City/ Town',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                snapshot.data!.data()!['city/Town'],
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Digital Address',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                snapshot.data!.data()!['digital Address'],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'House Number',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                snapshot.data!.data()!['house Number'],
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: TextButton(
                              onPressed: () async {
                                bool isIntrested = intrested[uid] == true;

                                if (isIntrested) {
                                  await _postManager.handleIntrested(
                                      docId: widget.docId, intrested: false);
                                  setState(() {
                                    interestedCount -= 1;
                                    isSelected = false;
                                    intrested[uid] = false;
                                  });
                                } else if (!isIntrested) {
                                  await _postManager.handleIntrested(
                                      docId: widget.docId, intrested: true);
                                  setState(() {
                                    interestedCount += 1;
                                    isSelected = true;
                                    intrested[uid] = true;
                                  });
                                }

                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return LandlordDetails(
                                    userId: userId,
                                  );
                                }));
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 4, 82, 146)),
                              child: const Text(
                                'Interested',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

//   Widget imagesView(BuildContext context) {
//     return StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
//         stream: _postManager.getRoomPictures(docID:widget.docId),
//         builder: (context, picSnapshot) {
//           if (picSnapshot.connectionState == ConnectionState.waiting &&
//               picSnapshot.data == null) {
//             return const Center(
//               child: CircularProgressIndicator.adaptive(),
//             );
//           }
//           if (picSnapshot.connectionState == ConnectionState.done &&
//               picSnapshot.data == null) {
//             return const Center(
//               child: Text('No data is available'),
//             );
//           }
//           return SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: 240,
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 200,
//                 color: Colors.black,
//                 child: Image.network(
//                   picSnapshot.data!.docs,
//                   fit: BoxFit.fill,
//                   height: 250,
//                   width: double.infinity,
//                 ),
//               ));
//         });
//   }
}
