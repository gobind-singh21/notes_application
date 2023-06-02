import 'package:flutter/material.dart';
import 'package:notes_application/app_widgets/home_widgets/front_page_item.dart';
import 'package:notes_application/global/current_user_data.dart';
import 'package:notes_application/models/product_class.dart';
import 'package:notes_application/screens/product_detail_screen.dart';
import 'package:notes_application/app_widgets/home_widgets/list_item.dart';
import 'package:notes_application/app_widgets/home_widgets/home_header.dart';
import 'package:notes_application/screens/login_screen.dart';
import 'package:notes_application/utils/dummy_data.dart';
import 'package:notes_application/utils/auth.dart';
import 'package:notes_application/global/dimensions.dart';
import 'package:notes_application/global/global.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double screenHeight = Dimensions.screenHeight;

  void moveToProductScreen(Product object) {
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => ProductScreen(object))));
  }

  asyncMethod() async {
    final docRef = db.collection('users').doc(currentFirebaseUser!.uid);
    final doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    UserData.name = data['name'];
    UserData.email = data['email'];
    UserData.number = data['number'];
    UserData.profileImageURL = data['profileImageURL'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asyncMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Auth().signOut();
          Navigator.popUntil(context, ModalRoute.withName('/someRoute'));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
                    child: TopItem(),
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
