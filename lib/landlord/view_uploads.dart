import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_accommodate/landlord/edit_description.dart';
import 'package:lets_accommodate/managers/post_manager.dart';
import 'package:lets_accommodate/tenant/landlord_details.dart';

class ViewUploads extends StatefulWidget {
  const ViewUploads({Key? key, required this.docId}) : super(key: key);
  final String docId;

  @override
  State<ViewUploads> createState() => _ViewUploadsState();
}

class _ViewUploadsState extends State<ViewUploads> {
  final PostManager _postManager = PostManager();
  final PageController _pageController = PageController();
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
              // var userId = snapshot.data!.data()!['user_id'];
              var pictures = snapshot.data!.data()!['pictures'];
              var docID = snapshot.data!.id;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                        height: 140.h,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: pictures.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width.w,
                              height: 240.h,
                              child: Container(
                                width: MediaQuery.of(context).size.width.w,
                                height: 200.h,
                                color: Colors.white,
                                child: Image.network(
                                  pictures[index],
                                  fit: BoxFit.fitWidth,
                                  height: 250.h,
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
                          activeColor: Colors.blueAccent,
                          activeSize: const Size(18.0, 9.0),
                          size: const Size.square(9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Center(
                          child: Text(
                            'Description',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18.sp),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Categories',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                )),
                            Text(
                              snapshot.data!.data()!['category'],
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Type',
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              snapshot.data!.data()!['type'],
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
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
                              'Kitchen',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            Text(
                              snapshot.data!.data()!['kitchen'],
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
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
                              'Washroom',
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              snapshot.data!.data()!['washroom'],
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
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
                              'Store Room',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            Text(
                              snapshot.data!.data()!['store Room'],
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
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
                              'Porch',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            Text(
                              snapshot.data!.data()!['porch'],
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
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
                              'Walled House',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            Text(
                              snapshot.data!.data()!['walled House'],
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
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
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            Text(
                              snapshot.data!.data()!['tiled'],
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
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
                              'Electricity',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            Text(
                              snapshot.data!.data()!['electricity'],
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Water',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            Text(
                              snapshot.data!.data()!['water Availability'],
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Price',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            Text(
                              '${snapshot.data!.data()!['price']} /month',
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Room size',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            Text(
                              snapshot.data!.data()!['size'],
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Region',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            Text(
                              snapshot.data!.data()!['region'],
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'City/ Town',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            Text(
                              snapshot.data!.data()!['city/Town'],
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Digital Address',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            Text(
                              snapshot.data!.data()!['digital Address'],
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'House Number',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            Text(
                              snapshot.data!.data()!['house Number'],
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return EditDescription(
                                  docId: docID,
                                );
                              }));
                            },
                            style: TextButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 4, 82, 146)),
                            child: Text(
                              'Edit Details',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.sp),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
