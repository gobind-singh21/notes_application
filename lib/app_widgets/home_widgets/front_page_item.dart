import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:notes_application/global/dimensions.dart';
import 'package:notes_application/models/product_class.dart';
import 'package:notes_application/utils/dummy_data.dart';
import 'package:notes_application/app_widgets/home_widgets/top_page.dart';

class TopItem extends StatefulWidget {
  // final List<Product> _products;
  // const TopItem({super.key});

  @override
  State<TopItem> createState() => _TopItemState();
}

class _TopItemState extends State<TopItem> {
  final List<Product> _products = DummyData.products;
  // _TopItemState(this._products);
  PageController pageController = PageController(viewportFraction: 0.85);
  double imageHeight = Dimensions.screenHeight / 3.2;
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

  @override
  Widget build(BuildContext context) {
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
              return BuildPage(_products[index]);
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
