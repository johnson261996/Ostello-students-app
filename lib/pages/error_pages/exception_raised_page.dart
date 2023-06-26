import 'package:flutter/material.dart';

import '../../utils/colours.dart';

class ExceptionRaisedPage extends StatelessWidget {
  final Exception error;

  const ExceptionRaisedPage({
    Key? key,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/error_page/error_code_500.png"),
                    const SizedBox(height: 20),
                    Text(
                      "Unknown Error Occurred!",
                      style: textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                error.toString(),
                style: textTheme.bodyMedium!.copyWith(
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
