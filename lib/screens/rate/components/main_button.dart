import 'package:flutter/material.dart';
import 'package:rider/screens/rate/components/rounded_button.dart';

import '../../../constants.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Submit',
          style: TextStyle(
              color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(width: kDefaultPadding),
        RoundedButton(
            icon: Icon(Icons.arrow_forward),
            iconColor: Colors.white,
            bgColor: kPrimaryColor,
            tap: () {})
      ],
    );
  }
}
