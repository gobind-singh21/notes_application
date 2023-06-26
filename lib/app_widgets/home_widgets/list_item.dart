import 'package:flutter/material.dart';
import 'package:notes_application/app_widgets/text_widgets/heading_text.dart';
import 'package:notes_application/app_widgets/text_widgets/normal_text.dart';
import 'package:notes_application/global/dimensions.dart';
import 'package:notes_application/screens/product_detail_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListItem extends StatelessWidget {
  final Map<String, dynamic> map;

  ListItem({super.key, required this.map});

  final double screenHeight = Dimensions.screenHeight;
  final double screenWidth = Dimensions.screenWidth;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(
        begin: 0,
        end: 1,
      ),
      duration: const Duration(milliseconds: 500),
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(
          opacity: value,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: (1 - value) * screenHeight / 30,
                horizontal: (1 - value) * screenHeight / 30),
            child: child,
          ),
        );
      },
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(
                map: map,
              ),
            ),
          );
        },
        child: Container(
          margin:
              const EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
          child: Row(
            children: [
              Container(
                width: screenWidth / 3.425,
                height: screenWidth / 3.425,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight / 43.85),
                    bottomLeft: Radius.circular(screenHeight / 43.85),
                  ),
                  color: Theme.of(context).cardColor,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight / 43.85),
                    bottomLeft: Radius.circular(screenHeight / 43.85),
                  ),
                  child: Image.network(map['productImageURLs'].first),
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
                    color: Theme.of(context).cardColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenHeight / 87.7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            HeadingText(
                              map['name'],
                              15,
                              TextOverflow.ellipsis,
                              Theme.of(context).textTheme.headlineLarge?.color,
                            ),
                            const SizedBox(
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
                              rating: map['rating'] / 10,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: screenWidth / 27.4,
                              direction: Axis.horizontal,
                            ),
                            NormalText(
                              ":${map['rating'] / 10} (${map['numberOfReviews']}) Reviews",
                              13,
                              null,
                              Colors.grey,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight / 95,
                        ),
                        Text(
                          "\u{20B9}${map['pricePerHour']} / hr",
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
