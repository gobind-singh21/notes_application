import 'package:flutter/material.dart';
import 'package:notes_application/global/dimensions.dart';

class ProfileItem extends StatelessWidget {
  final Icon _icon;
  final String _title;
  ProfileItem(this._icon, this._title, {super.key});

  final double height = Dimensions.screenHeight;
  final double width = Dimensions.screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width),
        color: Theme.of(context).cardColor,
      ),
      height: height / 15,
      padding: EdgeInsets.only(
        left: width / 20,
        right: width / 20,
      ),
      child: Row(
        children: [
          _icon,
          SizedBox(
            width: width / 40,
          ),
          Text(
            _title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              // color: Colors.black,
            ),
          ),
          const Expanded(child: SizedBox()),
          Icon(
            Icons.chevron_right_rounded,
            // color: Theme.of(context).iconTheme.color,
          ),
        ],
      ),
    );
  }
}
