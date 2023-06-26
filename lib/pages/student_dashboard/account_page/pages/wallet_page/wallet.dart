import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/student_provider.dart';
import '../../../../../providers/token_provider.dart';
import '../../../../../utils/colours.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    final tokensProvider = context.watch<TokensProvider>();
    final studentProvider = context.watch<StudentProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wallet',
          style: TextStyle(
            fontSize: 24,
            color: kBlack,
            fontFamily: 'DMSans',
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
        backgroundColor: kPureWhite,
        foregroundColor: kPrimary,
      ),
      backgroundColor: kPureWhite,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (studentProvider.wallet == null)
                  ? Column(
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text("Loading Wallet..."),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Available Balance",
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            IconButton(
                              onPressed: () async =>
                                  await studentProvider.getWalletDetails(
                                tokensProvider.tokens!.accessToken,
                              ),
                              icon: const Icon(
                                Icons.refresh_rounded,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "₹ ${studentProvider.wallet!.balance} /-",
                          style: const TextStyle(
                            fontSize: 46,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 20),
              Center(
                child: RichText(
                  text: const TextSpan(
                    text: "Check your ",
                    style: TextStyle(
                      color: kBlack,
                    ),
                    children: [
                      TextSpan(
                        text: "Balance",
                        style: TextStyle(
                          color: kBlack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: " & Claim your ",
                        style: TextStyle(
                          color: kBlack,
                        ),
                      ),
                      TextSpan(
                        text: "Offers",
                        style: TextStyle(
                          color: kBlack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: " here!",
                        style: TextStyle(
                          color: kBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
