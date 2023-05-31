import 'package:flutter/material.dart';
import 'package:notes_application/global/dimensions.dart';
import 'package:notes_application/models/product_class.dart';
import 'package:notes_application/app_widgets/unordered_list.dart';
import 'package:notes_application/screens/search_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:readmore/readmore.dart';

class ProductScreen extends StatefulWidget {
  final Product _product;
  const ProductScreen(this._product, {super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState(_product);
}

class _ProductScreenState extends State<ProductScreen> {
  PageController pageController = PageController(viewportFraction: 0.85);
  double imageHeight = Dimensions.screenHeight / 3.25;
  double width = Dimensions.screenWidth;

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

  final Product _product;

  _ProductScreenState(this._product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
            child: Icon(Icons.search),
          ),
          SizedBox(
            width: width / 20.55,
          ),
          InkWell(
            child: Icon(Icons.mic),
          ),
          SizedBox(
            width: width / 20.55,
          ),
          InkWell(
            child: Icon(Icons.shopping_cart),
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
                itemCount: _product.getProductImages().length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: width / 102.75,
                      right: width / 102.75,
                    ),
                    child: Image(
                      image: _product.getProductImages()[index].image,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: DotsIndicator(
                  dotsCount: _product.getProductImages().length,
                  position: _currPageValue.round(),
                  decorator: DotsDecorator(
                      size: const Size.square(9),
                      activeSize: const Size(18, 9),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(10),
              elevation: 4,
              child: SizedBox(
                width: width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ReadMoreText(
                    _product.getTitle(),
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
              elevation: 4,
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
                      UnorderedList(_product.getDescription()),
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
