import 'package:flutter/material.dart';
import 'package:notes_application/app_widgets/home_widgets/front_page_item.dart';
import 'package:notes_application/utils/auth.dart';
import 'package:notes_application/models/product_class.dart';
import 'package:notes_application/screens/login_screen.dart';
import 'package:notes_application/screens/product_detail_screen.dart';
import 'package:notes_application/app_widgets/home_widgets/list_item.dart';
import 'package:notes_application/app_widgets/home_widgets/home_header.dart';
import 'package:notes_application/utils/dummy_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void moveToProductScreen(Product object) {
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => ProductScreen(object))));
  }

  @override
  Widget build(BuildContext context) {
    double? screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Auth().signOut();
          Navigator.popUntil(context, ModalRoute.withName('/someRoute'));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: Container(
          height: screenHeight / 15.17,
          width: screenHeight / 15.17,
          decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.circular(screenHeight / 11.17),
          ),
          child: Icon(
            Icons.history,
            size: screenWidth / 15,
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
                    child: TopItem(DummyData.products),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: DummyData.products.length,
                    itemBuilder: (context, index) {
                      return ListItem(DummyData.products[index]);
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
