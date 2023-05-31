// import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:notes_application/app_widgets/text_widgets/heading_text.dart';
import 'package:notes_application/global/dimensions.dart';
import 'package:notes_application/screens/product_detail_screen.dart';
import 'package:notes_application/models/product_class.dart';
// import 'package:notes_application/utils/dummy_data.dart';

class BuildPage extends StatelessWidget {
  // final int _index;
  final Product _product;
  BuildPage(this._product);

  final double imageHeight = Dimensions.screenHeight / 3.2;
  final double width = Dimensions.screenWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductScreen(_product)));
      },
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
                    image: _product.getIcon(),
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
                        HeadingText(_product.getTitle(), imageHeight / 20,
                            TextOverflow.ellipsis, Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
      // ),
    );
  }
}
