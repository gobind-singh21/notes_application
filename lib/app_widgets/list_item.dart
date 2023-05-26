import 'package:flutter/material.dart';
import 'package:notes_application/models/product_class.dart';
import 'package:notes_application/screens/product_detail_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListItem extends StatefulWidget {
  final Product _product;
  const ListItem(this._product, {super.key});

  @override
  State<ListItem> createState() {
    return _ListItemState(_product);
  }
}

class _ListItemState extends State<ListItem> {
  final Product _product;
  _ListItemState(this._product);

  void moveToProductScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => ProductScreen(_product))));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => moveToProductScreen(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
        child: Row(
          children: [
            Container(
              width: screenWidth / 3.425,
              height: screenWidth / 3.425,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(108, 93, 93, 93),
                    offset: Offset(1, 5),
                    blurRadius: 4,
                  )
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenHeight / 43.85),
                  bottomLeft: Radius.circular(screenHeight / 43.85),
                ),
                color: Colors.white,
                image: DecorationImage(
                  image: _product.getIcon(),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: screenWidth / 3.425,
                width: screenWidth / 2.055,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(screenHeight / 43.85),
                    bottomRight: Radius.circular(screenHeight / 43.85),
                  ),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(108, 93, 93, 93),
                      offset: Offset(1, 5),
                      blurRadius: 4,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenHeight / 87.7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _product.getTitle(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.verified,
                            size: screenWidth / 27.4,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: _product.getRating(),
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: screenWidth / 27.4,
                            direction: Axis.horizontal,
                          ),
                          Text(
                            ":${_product.getRating()} (${_product.getNumberOfReviews()}) Reviews",
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
