import 'package:flutter/material.dart';

class Product {
  final String _title;
  final List<String> _description;
  final String _owner;
  final List<Image> _productImages;
  final AssetImage _productIcon;
  final double _rating;
  final int _numberOfReviews;
  final List<String> _reviews;

  Product(this._title, this._description, this._owner, this._productImages,
      this._productIcon, this._rating, this._numberOfReviews, this._reviews);

  String getTitle() {
    return _title;
  }

  List<String> getDescription() {
    return _description;
  }

  String getOwner() {
    return _owner;
  }

  List<Image> getProductImages() {
    return _productImages;
  }

  AssetImage getIcon() {
    return _productIcon;
  }

  double getRating() {
    return _rating;
  }

  int getNumberOfReviews() {
    return _numberOfReviews;
  }

  List<String> getReviews() {
    return _reviews;
  }
}
