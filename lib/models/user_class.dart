class EndUser {
  final String _name;
  // final int _age;
  final String _email;
  final String _phoneNumber;
  final List<Borrowed>? _history;
  String _profileImageUrl;

  EndUser(
    this._name,
    // this._age,
    this._email,
    this._phoneNumber,
    this._profileImageUrl,
    this._history,
  );

  String getName() {
    return _name;
  }

  String getEmail() {
    return _email;
  }

  String getNumber() {
    return _phoneNumber;
  }

  String getProfileImage() {
    return _profileImageUrl;
  }

  List<Borrowed>? getHistory() {
    return _history;
  }
}

class Borrowed {
  final String _onwerID;
  final String _productID;
  final int _numberOfDays;
  final int _ratingGiven;
  final int _price;
  final String _reviewGiven;

  Borrowed(this._onwerID, this._productID, this._numberOfDays,
      this._ratingGiven, this._price, this._reviewGiven);
}
