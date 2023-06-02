class EndUser {
  String _name;
  // final int _age;
  String _email;
  String _phoneNumber;
  List<Borrowed>? _history;
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

  void setName(String name) {
    _name = name;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setNumber(String number) {
    _phoneNumber = number;
  }

  void setProfileImageUrl(String url) {
    _profileImageUrl = url;
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
