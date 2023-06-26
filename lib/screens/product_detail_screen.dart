import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_application/global/dimensions.dart';
import 'package:notes_application/app_widgets/unordered_list.dart';
import 'package:notes_application/screens/search_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:readmore/readmore.dart';
import 'package:notes_application/global/global.dart';

import '../app_widgets/text_widgets/heading_text.dart';

class ProductScreen extends StatefulWidget {
  final Map<String, dynamic> map;

  const ProductScreen({super.key, required this.map});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final double height = Dimensions.screenHeight;
  final double width = Dimensions.screenWidth;
  PageController pageController = PageController(viewportFraction: 0.85);
  final double imageHeight = Dimensions.screenHeight / 3.25;

  Future placeOrder() async {
    DateTime startTimeStamp = DateTime.now();
    final userDocRef = db.collection('users').doc(currentFirebaseUser!.uid);
    final productDocRef =
        db.collection('products').doc(widget.map['productID']);
    final orderRef = db.collection('orders');
    String orderID = "";
    Map<String, dynamic> orderInfo = {
      'UID': currentFirebaseUser!.uid,
      'productID': widget.map['productID'],
      'startTimeStamp': startTimeStamp,
    };
    await orderRef.add(orderInfo).then((documentSnapshot) {
      orderID = documentSnapshot.id;
    });
    final userDocData = await userDocRef.get();
    final productDocData = await productDocRef.get();
    final userData = userDocData.data() as Map<String, dynamic>;
    final productData = productDocData.data() as Map<String, dynamic>;
    userData['history'].add(orderID);
    productData['history'].add(orderID);
    await userDocRef.update({'history': userData['history']});
    await productDocRef.update({'history': productData['history']});
    Fluttertoast.showToast(msg: 'Order placed successfully');
  }

  var _currPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  // final Product _product;

  // _ProductScreenState(this._product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () => placeOrder(),
        child: Container(
          height: width / 10,
          width: height / 10,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            // color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: HeadingText('Order', width / 25, null, Theme.of(context).textTheme.headlineLarge?.color),
        ),
      ),
      appBar: AppBar(
        // backgroundColor: Colors.cyan,
        elevation: 4,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            child: Icon(
              Icons.search,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          SizedBox(
            width: width / 20.55,
          ),
          InkWell(
            child: Icon(
              Icons.mic,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          SizedBox(
            width: width / 20.55,
          ),
          InkWell(
            child: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          SizedBox(
            width: width / 20.55,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: imageHeight, // Adjust the height as needed
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.map['productImageURLs'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: width / 102.75,
                      right: width / 102.75,
                    ),
                    child: Image.network(
                      widget.map['productImageURLs'][index],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: DotsIndicator(
                  dotsCount: widget.map['productImageURLs'].length,
                  position: _currPageValue.round(),
                  decorator: DotsDecorator(
                    size: const Size.square(9),
                    activeSize: const Size(18, 9),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(10),
              elevation: 0,
              child: SizedBox(
                width: width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ReadMoreText(
                    widget.map['name'],
                    trimLines: 2,
                    colorClickableText: Colors.blue,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(10),
              elevation: 0,
              child: SizedBox(
                width: width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      UnorderedList(widget.map['description']),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
