import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:notes_application/screens/product_detail_screen.dart';
import 'package:notes_application/models/product_class.dart';

class TopItem extends StatefulWidget {
  final List<Product> _products;
  const TopItem(this._products, {super.key});

  @override
  State<TopItem> createState() => _TopItemState(_products);
}

class _TopItemState extends State<TopItem> {
  final List<Product> _products;
  _TopItemState(this._products);
  PageController pageController = PageController(viewportFraction: 0.85);
  late double imageHeight;
  late double width;

  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
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

  Widget buildPageItem(int index) {
    imageHeight = MediaQuery.of(context).size.height / 3.2465608466;
    width = MediaQuery.of(context).size.width;
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = imageHeight * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = imageHeight * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = imageHeight * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, imageHeight * (1 - currScale) / 2, 0);
    }
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductScreen(_products[index])));
      },
      child: Transform(
        transform: matrix,
        child: Padding(
            padding: EdgeInsets.only(left: width / 205.5, right: width / 205.5),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                  height: imageHeight / 1.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(108, 93, 93, 93),
                        offset: Offset(1, 5),
                        blurRadius: 4,
                      )
                    ],
                    color: Colors.white,
                    image: DecorationImage(
                      image: _products[index].getIcon(),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: imageHeight / 1.5,
                    ),
                    Container(
                      height: imageHeight / 4,
                      width: width / 2.2,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(108, 93, 93, 93),
                            offset: Offset(1, 5),
                            blurRadius: 4,
                          )
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 215, 215, 215),
                      ),
                      child: Column(
                        children: [
                          Text(
                            _products[index].getTitle(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: imageHeight / 20,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    imageHeight = MediaQuery.of(context).size.height / 3.2;
    width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          alignment: AlignmentDirectional.topCenter,
          height: imageHeight, // Adjust the height as needed
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: _products.length,
            itemBuilder: (BuildContext context, int index) {
              return buildPageItem(index);
            },
          ),
        ),
        Center(
          heightFactor: 0.0,
          child: DotsIndicator(
            dotsCount: _products.length,
            position: _currPageValue.round(),
            decorator: DotsDecorator(
                size: const Size.square(9),
                activeSize: const Size(18, 9),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
          ),
        ),
        // ),
      ],
    );
  }
}
