import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_application/app_widgets/home_widgets/front_page_item.dart';
import 'package:notes_application/global/current_user_data.dart';
import 'package:notes_application/global/global.dart';
import 'package:notes_application/screens/history_screen.dart';
// import 'package:notes_application/models/product_class.dart';
import 'package:notes_application/screens/product_detail_screen.dart';
import 'package:notes_application/app_widgets/home_widgets/list_item.dart';
import 'package:notes_application/app_widgets/home_widgets/home_header.dart';
// import 'package:notes_application/screens/login_screen.dart';
// import 'package:notes_application/utils/dummy_data.dart';
// import 'package:notes_application/utils/auth.dart';
import 'package:notes_application/global/dimensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double screenHeight = Dimensions.screenHeight;
  List<QueryDocumentSnapshot> documentSnapshot = [];
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> topProducts = [];

  void moveToProductScreen(Map<String, dynamic> map) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductScreen(
          map: map,
        ),
      ),
    );
  }

  asyncMethod() async {
    await UserData.fetchData();
  }

  fetchProducts() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('products').get();
    setState(() {
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
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileImagePath =
        'users/${currentFirebaseUser!.uid}/profile_images/profile.jpg';
    if (!UserData.userDataSet) {
      asyncMethod();
    }
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HistoryScreen()));
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
          HomeHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10),
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> map = products[index];
                      return InkWell(
                        onTap: () => moveToProductScreen(map),
                        child: ListItem(map: map),
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
