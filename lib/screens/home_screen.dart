import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_application/app_widgets/home_widgets/front_page_item.dart';
import 'package:notes_application/global/current_user_data.dart';
import 'package:notes_application/global/global.dart';
import 'package:notes_application/screens/history_screen.dart';
import 'package:notes_application/screens/product_detail_screen.dart';
import 'package:notes_application/app_widgets/home_widgets/list_item.dart';
import 'package:notes_application/app_widgets/home_widgets/home_header.dart';
import 'package:notes_application/global/dimensions.dart';
import 'package:notes_application/screens/profile_screen.dart';
import 'package:notes_application/screens/search_screen.dart';

import '../app_widgets/text_widgets/heading_text.dart';

List<Map<String, dynamic>> products = [];
List<Map<String, dynamic>> topProducts = [];
double screenHeight = Dimensions.screenHeight;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future fetchUserData() async {
    await UserData.fetchData();
  }

  Future getProducts() async {
    // await UserData.fetchData();
    QuerySnapshot querySnapshot = await db.collection('products').get();
    products = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['productID'] = doc.id;
      return data;
    }).toList();
    for (var prod in products) {
      if (prod['top']) {
        topProducts.add(prod);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HistoryScreen()));
        },
        child: Container(
          height: Dimensions.screenHeight / 15.17,
          width: Dimensions.screenHeight / 15.17,
          decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius:
                BorderRadius.circular(Dimensions.screenHeight / 11.17),
          ),
          child: Icon(
            Icons.history,
            size: Dimensions.screenWidth / 15,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: screenHeight / 8.5,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(108, 93, 93, 93),
                offset: Offset(0, screenHeight / 296),
                blurRadius: 4,
              )
            ], color: Colors.white),
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenWidth / 45,
                  top: screenHeight / 23,
                  right: screenWidth / 45,
                  bottom: screenHeight / 120),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ),
                    ),
                    child: Container(
                      height: screenHeight / 20,
                      width: screenHeight / 20,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            Colors.cyan.shade600,
                            Colors.cyan.shade200,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(screenWidth / 80),
                      ),
                      child: Icon(
                        Icons.person,
                        size: screenHeight / 40,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth / 45,
                        right: screenWidth / 45,
                      ),
                      child: FutureBuilder(
                        future: fetchUserData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const HeadingText(
                              'Loading region...',
                              20,
                              TextOverflow.fade,
                              Colors.black,
                            );
                          }
                          else if(snapshot.hasError) {
                            Fluttertoast.showToast(msg: 'Error occurred in loading region please restart app');
                            return const HeadingText(
                              'Error occurred in loading region',
                              20,
                              TextOverflow.fade,
                              Colors.black,
                            );
                          }
                          return const Region();
                        },
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchScreen()));
                    },
                    child: Container(
                      height: screenHeight / 20,
                      width: screenHeight / 20,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            Colors.cyan.shade600,
                            Colors.cyan.shade200,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(screenWidth / 80),
                      ),
                      child: Icon(
                        Icons.search,
                        size: screenHeight / 40,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(108, 93, 93, 93),
                        offset: Offset(0, screenHeight / 296),
                        blurRadius: 4,
                      ),
                    ], color: Colors.white70),
                    height: screenHeight / 2.95,
                    child: TopItem(map: topProducts),
                  ),
                  FutureBuilder(
                    future: getProducts(),
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
                                'Error occurred try again later...',
                                style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> map = products[index];
                          return InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductScreen(
                                  map: map,
                                ),
                              ),
                            ),
                            child: ListItem(map: map),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
