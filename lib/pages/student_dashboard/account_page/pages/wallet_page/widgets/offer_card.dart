import 'package:flutter/material.dart';

import '../../../../../../utils/colours.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: kPureWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 2,
            color: kLightGray,
            offset: Offset(
              2,
              10,
            ),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Course @99",
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Apply",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Roboto",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
