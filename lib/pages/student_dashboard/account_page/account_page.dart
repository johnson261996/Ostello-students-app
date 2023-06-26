import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages/institute_rating_page/find_institute.dart';
import './pages/invite_and_earn_page/invite_and_earn.dart';
import './pages/profile_page/profile.dart';
import './pages/wallet_page/wallet.dart';
import './widgets/custom_button.dart';
import '../../../providers/chat_room_provider.dart';
import '../../../providers/student_provider.dart';
import '../../../providers/token_provider.dart';
import '../../../utils/colours.dart';
import '../../../utils/constants.dart';
import '../../mentor_dashboard/pages/mentor_profile/mentor_profile.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final tokensProvider = context.watch<TokensProvider>();
    final studentProvider = context.watch<StudentProvider>();
    final chatRoomProvider = context.read<ChatRoomProvider>();

    return Scaffold(
      backgroundColor: kPureWhite,
      body: SafeArea(
        child: Container(
          height: media.height,
          width: media.width,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${studentProvider.student.firstName} ${studentProvider.student.lastName}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          text: 'Profile Strength : ',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Roboto',
                            color: Colors.black,
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                              text:
                                  '${studentProvider.profileStrengthCategory} ',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto',
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "${studentProvider.profileStrength}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                color: studentProvider.profileStrengthColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 10,
                        width: 250,
                        child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, idx) => Container(
                            height: 8,
                            width: 50,
                            margin: const EdgeInsets.only(right: 1),
                            decoration: BoxDecoration(
                              color: idx <
                                      studentProvider
                                          .profileStrengthFilledBlocks
                                  ? studentProvider.profileStrengthColor
                                  : kLightGray,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  studentProvider.student.avatar != null
                      ? CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                            "$mediaHost/${studentProvider.student.avatar!.key}",
                          ),
                        )
                      : const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(
                            "assets/images/homepage/avatar.png",
                          ),
                        ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 21),
                child: Column(
                  children: [
                    PageButton(
                      pageName: 'Profile',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => const ProfilePage(),
                        ),
                      ),
                    ),
                    PageButton(
                      pageName: 'Mentor',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => const MentorProfile(),
                        ),
                      ),
                    ),
                    PageButton(
                      pageName: 'My Wallet',
                      onTap: () {
                        if (tokensProvider.tokens != null) {
                          studentProvider.getWalletDetails(
                            tokensProvider.tokens!.accessToken,
                          );
                        }

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (builder) => const WalletPage(),
                          ),
                        );
                      },
                    ),
                    PageButton(
                      pageName: 'Refer & earn',
                      onTap: () {
                        if (tokensProvider.tokens != null) {
                          studentProvider.getWalletDetails(
                            tokensProvider.tokens!.accessToken,
                          );
                        }

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (builder) => const InviteAndEarnPage(),
                          ),
                        );
                      },
                    ),
                    PageButton(
                      pageName: 'Rate your institute',
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (builder) => const FindInstitute(),
                        ),
                      ),
                    ),
                    PageButton(
                      pageName: 'Logout',
                      onTap: () {
                        studentProvider.logout();
                        chatRoomProvider.clearMessages();

                        Navigator.of(context)
                            .pushReplacementNamed("/getstarted");
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
