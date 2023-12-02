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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future fetchUserData() async {
    await UserData.fetchData();
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    QuerySnapshot querySnapshot = await db.collection('products').get();
    List<Map<String, dynamic>> products = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['productID'] = doc.id;
      return data;
    }).toList();
    return products;
  }

  Future<List<Map<String, dynamic>>> getTopProducts() async {
    QuerySnapshot querySnapshot = await db.collection('products').get();
    List<Map<String, dynamic>> products = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['productID'] = doc.id;
      return data;
    }).toList();
    List<Map<String, dynamic>> topProducts = [];
    for (var prod in products) {
      if (prod['top']) {
        topProducts.add(prod);
      }
    }
    return topProducts;
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
          height: MediaQuery.of(context).size.height / 15.17,
          width: MediaQuery.of(context).size.height / 15.17,
          decoration: BoxDecoration(
            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.height / 11.17),
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
            height: MediaQuery.of(context).size.height / 8.5,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenWidth / 45,
                  top: MediaQuery.of(context).size.height / 23,
                  right: screenWidth / 45,
                  bottom: MediaQuery.of(context).size.height / 120),
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
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.height / 20,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(screenWidth / 80),
                      ),
                      child: Icon(
                        Icons.person,
                        size: MediaQuery.of(context).size.height / 40,
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
                          } else if (snapshot.hasError) {
                            Fluttertoast.showToast(
                                msg:
                                    'Error occurred in loading region please restart app');
                            return const HeadingText(
                              'Error occurred in loading region',
                              20,
                              TextOverflow.fade,
                              Colors.black,
                            );
                          }
                          return TweenAnimationBuilder(
                            duration: const Duration(milliseconds: 1000),
                            tween: Tween<double>(begin: 0, end: 1),
                            builder: (BuildContext context, double value,
                                Widget? child) {
                              return Opacity(
                                opacity: value,
                                child: child,
                              );
                            },
                            child: const Region(),
                          );
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
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.height / 20,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(screenWidth / 80),
                      ),
                      child: Icon(
                        Icons.search,
                        size: MediaQuery.of(context).size.height / 40,
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
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  FutureBuilder(
                    future: getTopProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Error occured while loading data!!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .color,
                              fontSize: 20,
                            ),
                          ),
                        );
                      } else {
                        List<Map<String, dynamic>> topProducts =
                            snapshot.data ?? [];
                        return Container(
                          padding: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(108, 93, 93, 93),
                                offset: Offset(0,
                                    MediaQuery.of(context).size.height / 296),
                                blurRadius: 4,
                              ),
                            ],
                            color: Colors.white70,
                          ),
                          height: MediaQuery.of(context).size.height / 2.95,
                          child: TopItem(map: topProducts),
                        );
                      }
                    },
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
                      List<Map<String, dynamic>> products = snapshot.data ?? [];
                      if (products.isEmpty) {
                        return Expanded(
                          child: Center(
                            child: Text(
                              "No products to show right now",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .color,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height / 100,
                              ),
                              overflow: TextOverflow.fade,
                            ),
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
