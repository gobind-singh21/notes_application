import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:notes_application/app_widgets/text_widgets/heading_text.dart';
import 'package:notes_application/app_widgets/text_widgets/normal_text.dart';
import 'package:notes_application/global/dimensions.dart';
import 'package:notes_application/global/global.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final double height = Dimensions.screenHeight;
  final double width = Dimensions.screenWidth;
  List<dynamic> orderIDs = [];

  void returnProduct({required String orderID}) async {
    DateTime endTimeStamp = DateTime.now();
    final orderDocRef = db.collection('orders').doc(orderID);
    final doc = await orderDocRef.get();
    Map<String, dynamic> orderInfo = doc.data() as Map<String, dynamic>;
    final productDocRef = db.collection('products').doc(orderInfo['productID']);
    final prodDoc = await productDocRef.get();
    final prodInfo = prodDoc.data();
    Timestamp startTime = orderInfo['startTimeStamp'];
    DateTime startTimeStamp = startTime.toDate();
    double pricePaid = (endTimeStamp.difference(startTimeStamp).inMinutes * prodInfo!['pricePerHour'] / 60).toPrecision(2);
    bool paymentConfirmation = false;
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                paymentConfirmation = true;
                Navigator.of(context).pop();
              },
              child: const Text("Confirm"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            )
          ],
          content: Row(
            children: [
              const CircularProgressIndicator(),
              Container(
                  margin: const EdgeInsets.only(left: 7),
                  child: Text("Price to be paid is: \u{20B9}${pricePaid.toPrecision(2)}")),
            ],
          ),
        );
      },
    );
    if(paymentConfirmation) {
      orderDocRef.update({
        'endTimeStamp' : endTimeStamp,
        'pricePaid':pricePaid.toPrecision(2),
      });
      Fluttertoast.showToast(msg: 'Order returned successfully');
    }
  }

  Future fetchHistory() async {
    try {
      final userDocRef = db.collection('users').doc(currentFirebaseUser!.uid);
      final doc = await userDocRef.get();
      final userData = doc.data() as Map<String, dynamic>;
      orderIDs = userData['history'];
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> fetchOrderInfo(int index) async {
    final orderDocRef = db.collection('orders').doc(orderIDs[index]);
    final doc = await orderDocRef.get();
    final orderData = doc.data() as Map<String, dynamic>;
    final productRef = db.collection('products').doc(orderData['productID']);
    final prodDoc = await productRef.get();
    final prodData = prodDoc.data() as Map<String, dynamic>;
    return prodData;
  }

  Future<Widget> createReturn({required String orderID}) async {
    final orderDocRef = db.collection('orders').doc(orderID);
    final doc = await orderDocRef.get();
    final docData = doc.data() as Map<String, dynamic>;
    if (docData['endTimeStamp'] == null) {
      print('return');
      return Expanded(
        child: InkWell(
          onTap: () {
            returnProduct(orderID: orderID);
            setState(() {});
          },
          child: Container(
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(height / 43.85),
              ),
              color: Colors.cyan,
            ),
            child: const Text('Return'),
          ),
        ),
      );
    } else {
      print('no return');
      return Expanded(
        child: Container(
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(height / 43.85),
            ),
            color: Colors.cyan,
          ),
          child: Text("Price paid : ${docData['pricePaid']}"),
        ),
      );
    }
  }

  Widget createLast(String orderID) {
    return FutureBuilder<Widget>(
      future: createReturn(orderID: orderID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text("Error occurred! Try again later...");
        } else if (snapshot.hasData) {
          return snapshot.data!;
        } else {
          return Container();
        }
      },
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchHistory();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.cyan,
        shadowColor: Colors.transparent,
        title: const HeadingText(
          'History',
          20,
          null,
          Colors.black,
        ),
      ),
      body: FutureBuilder(
        future: fetchHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.error_rounded,
                    color: Colors.grey,
                    size: 50,
                  ),
                  SizedBox(
                    height: height / 70,
                  ),
                  const Text(
                    'Error occured try again later...',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: orderIDs.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: fetchOrderInfo(index),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text("Error occured! Try again later...");
                    } else if (snapshot.hasData) {
                      final prodData = snapshot.data;
                      if (prodData != null) {
                        return Container(
                          margin: const EdgeInsets.only(
                              bottom: 10, top: 10, left: 15, right: 15),
                          child: Row(
                            children: [
                              Container(
                                width: width / 3.425,
                                height: width / 3.425,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(108, 93, 93, 93),
                                      offset: Offset(1, 5),
                                      blurRadius: 4,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(height / 43.85),
                                    bottomLeft: Radius.circular(height / 43.85),
                                  ),
                                  color: Colors.white,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(height / 43.85),
                                    bottomLeft: Radius.circular(height / 43.85),
                                  ),
                                  child: Image.network(
                                    prodData['productImageURLs'].first,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: width / 3.425,
                                  width: width / 2.055,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(height / 43.85),
                                      bottomRight:
                                          Radius.circular(height / 43.85),
                                    ),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromARGB(108, 93, 93, 93),
                                        offset: Offset(1, 5),
                                        blurRadius: 4,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      // left: height / 87.7,
                                      // right: height / 87.7,
                                      top: height / 87.7,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            HeadingText(
                                                prodData['name'],
                                                15,
                                                TextOverflow.ellipsis,
                                                Colors.black),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Icon(
                                              Icons.verified,
                                              size: width / 27.4,
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            RatingBarIndicator(
                                              rating: prodData['rating'] / 10,
                                              itemBuilder: (context, index) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              itemCount: 5,
                                              itemSize: width / 27.4,
                                              direction: Axis.horizontal,
                                            ),
                                            NormalText(
                                              ":${prodData['rating'] / 10} (${prodData['numberOfReviews']}) Reviews",
                                              13,
                                              null,
                                              Colors.grey,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height / 95,
                                        ),
                                        Text(
                                          "\u{20B9}${prodData['pricePerHour']} / hr",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        createLast(orderIDs[index]),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    return Center(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.error_rounded,
                            color: Colors.grey,
                            size: 50,
                          ),
                          SizedBox(
                            height: height / 70,
                          ),
                          const Text(
                            'Seems like there is some error try again later...',
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
