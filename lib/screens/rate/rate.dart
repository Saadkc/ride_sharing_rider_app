import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../constants.dart';
import '../../proportionate.dart';
import 'components/app_header.dart';
import 'components/custom_app_bar.dart';
import 'components/main_button.dart';
import 'components/multiline_input.dart';
import 'components/ride_stat.dart';

class RateScreen extends StatefulWidget {
  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  @override
  double rating = 0;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            AppHeader(),
            Positioned(
                top: -380,
                left: -187,
                child: Opacity(
                    opacity: 0.9, child: Image.asset('assets/images/bg.png'))),
            SafeArea(
                child: Padding(
              padding: EdgeInsets.all(kDefaultPadding * 2),
              child: Column(
                children: [
                  CustomAppBar(),
                  SizedBox(height: kDefaultPadding * 2),
                  Image.asset(
                    'assets/images/driver.png',
                    width: getScreenPropotionWidth(166, size),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  const Text(
                    'Your Driver:',
                    style: TextStyle(color: kTextLightColor, fontSize: 14),
                  ),
                  const Text(
                    'Shehroz Akbar',
                    style: TextStyle(
                        color: kTextColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: kDefaultPadding),
                  Divider(
                    color: kTextLightColor,
                  ),
                  SizedBox(height: kDefaultPadding),
                  RideStats(),
                  SizedBox(height: kDefaultPadding),
                  Divider(
                    color: kTextLightColor,
                  ),
                  SizedBox(height: kDefaultPadding),
                  // Text(
                  //   'Mark,',
                  //   style: TextStyle(
                  //     color: kTextLightColor,
                  //     fontSize: 14,
                  //   ),
                  // ),
                  Text(
                    'How is your trip?',
                    style: TextStyle(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                  RatingBar.builder(
                    minRating: 1,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    onRatingUpdate: (rating) => setState(() {
                      this.rating = rating;
                    }),
                  ),
                  // SmoothStarRating(
                  //   allowHalfRating: false,
                  //   // onRated: (v) {},
                  //   starCount: 5,
                  //   onRatingChanged: (v) {},

                  //   size: 35,
                  //   // isReadOnly: false,
                  //   spacing: kDefaultPadding,
                  // ),
                  SizedBox(height: kDefaultPadding),
                  MultilineInput(),
                  SizedBox(height: kDefaultPadding),
                  MainButton()
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
