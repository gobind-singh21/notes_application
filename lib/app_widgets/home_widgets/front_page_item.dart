import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:notes_application/global/dimensions.dart';
// import 'package:notes_application/models/product_class.dart';
// import 'package:notes_application/utils/dummy_data.dart';
import 'package:notes_application/app_widgets/home_widgets/top_page.dart';

class TopItem extends StatefulWidget {
  final List<Map<String, dynamic>> map;
  // final List<Product> _products;
  const TopItem({super.key, required this.map});

  @override
  State<TopItem> createState() => _TopItemState();
}

class _TopItemState extends State<TopItem> {
  // _TopItemState(this._products);
  PageController pageController = PageController(viewportFraction: 0.85);
  double imageHeight = Dimensions.screenHeight / 3;
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
    if (widget.map.isEmpty) {
      return Stack(
        children: [
          Container(
            height: imageHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage('assets/images/search_not_found_penguin.jpg'),
              ),
            ),
          ),
        ],
      );
    }
    return Column(
      children: [
        Container(
          alignment: AlignmentDirectional.topCenter,
          height: imageHeight, // Adjust the height as needed
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.map.length,
            itemBuilder: (BuildContext context, int index) {
              // print(index);
              return BuildPage(
                map: widget.map[index],
              );
            },
          ),
        ),
        Center(
          heightFactor: 0.0,
          child: DotsIndicator(
            dotsCount: widget.map.length,
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
