import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final Icon _icon;
  final String _title;
  const ProfileItem(this._icon, this._title);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      height: height / 15,
      padding: EdgeInsets.only(left: width / 80),
      child: Row(
        children: [
          _icon,
          SizedBox(
            width: width / 40,
          ),
          Text(
            _title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
