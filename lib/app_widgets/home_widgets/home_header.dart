import 'package:flutter/material.dart';
import 'package:notes_application/app_widgets/text_widgets/heading_text.dart';
import 'package:notes_application/global/dimensions.dart';
import 'package:notes_application/global/current_user_data.dart';
import 'package:notes_application/utils/auth.dart';
import 'package:csc_picker/csc_picker.dart';

double screenHeight = Dimensions.screenHeight;
double screenWidth = Dimensions.screenHeight;

class Region extends StatefulWidget {
  const Region({super.key});

  @override
  State<Region> createState() => _RegionState();
}

class _RegionState extends State<Region> {
  String countryValue = UserData.country;
  String stateValue = UserData.state;
  String cityValue = UserData.city;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: const EdgeInsets.only(
                bottom: 10,
              ),
              icon: const Icon(Icons.location_city_rounded),
              title: const HeadingText(
                  'Select your region', 20, TextOverflow.fade, Colors.black),
              scrollable: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth / 80),
              ),
              content: Column(
                children: [
                  CSCPicker(
                    onCountryChanged: (value) {
                      countryValue = value;
                    },
                    onStateChanged: (value) {
                      if(value != null) {
                        stateValue = value;
                      }
                    },
                    onCityChanged: (value) {
                      if(value != null) {
                        cityValue = value;
                      }
                    },
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    int index = countryValue.indexOf(' ');
                    String newCountryValue = countryValue.substring(index + 1);
                    countryValue = newCountryValue;
                    await Auth().addUserInfo({
                      'country': countryValue,
                      'state': stateValue,
                      'city': cityValue
                    });
                    UserData.city = cityValue;
                    UserData.state = stateValue;
                    UserData.country = countryValue;
                    Navigator.of(context).pop();
                  },
                  child: const Text("Confirm"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                )
              ],
            );
          },
          barrierDismissible: false,
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$stateValue,$countryValue",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenHeight / 60,
            ),
          ),
          Row(
            children: [
              Text(
                cityValue,
                style: TextStyle(
                  fontSize: screenHeight / 80,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: screenHeight / 45,
              )
            ],
          )
        ],
      ),
    );
  }
}