import 'package:notes_application/models/product_class.dart';

class Owner {
  final String _name;
  final String _phoneNumber;
  final String _address;
  final String _email;
  final List<Product> _products;

  Owner(this._name, this._phoneNumber, this._address, this._email,
      this._products);

  String getName() {
    return _name;
  }

  String getPhoneNumber() {
    return _phoneNumber;
  }

  String getAddress() {
    return _address;
  }

  String getEmail() {
    return _email;
  }

  List<Product> getProducts() {
    return _products;
  }
}
