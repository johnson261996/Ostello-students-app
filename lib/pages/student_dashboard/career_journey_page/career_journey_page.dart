import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import './widgets/chat_message_widget.dart';
import '../../../models/chat.dart';
import '../../../providers/chat_room_provider.dart';
import '../../../providers/student_provider.dart';
import '../../../utils/colours.dart';

class CareerJourneyPage extends StatefulWidget {
  const CareerJourneyPage({Key? key}) : super(key: key);

  @override
  State<CareerJourneyPage> createState() => _CareerJourneyPageState();
}

class _CareerJourneyPageState extends State<CareerJourneyPage> {
  String? _chat;

  bool _showScrollToBottomIndicator = true;

  final uuid = const Uuid();
  final GlobalKey<FormState> _key = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(scrollToBottomIndicator);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceWidth = MediaQuery.of(context).size.width;
    final studentProvider = context.read<StudentProvider>();
    final chatRoomProvider = context.watch<ChatRoomProvider>();

    return Scaffold(
      backgroundColor: kPureWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        foregroundColor: kPrimary,
        elevation: 1,
        title: Text(
          "Ostello",
          style: textTheme.headlineMedium,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Scrollbar(
                    controller: _scrollController,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: chatRoomProvider.messages.length + 1,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      itemBuilder: (context, index) {
                        if (index < chatRoomProvider.messages.length) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ChatMessage(
                              chat: chatRoomProvider.messages[index],
                            ),
                          );
                        } else if (chatRoomProvider.currentResponse != null) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _scrollController.jumpTo(
                                _scrollController.position.maxScrollExtent);
                          });

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ChatMessage(
                              chat: Chat(
                                id: uuid.v4(),
                                isLeft: true,
                                sender: "assistant",
                                message: chatRoomProvider.currentResponse!,
                                timeStamp:
                                    "${DateTime.now().hour}:${DateTime.now().minute}",
                              ),
                            ),
                          );
                        }

                        if (chatRoomProvider.quickReplies != null) {
                          print(chatRoomProvider.quickReplies);

                          return Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: chatRoomProvider.quickReplies!.length,
                              separatorBuilder: (ctx, idx) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (ctx, idx) => GestureDetector(
                                onTap: () => sendMessage(
                                  chatRoomProvider,
                                  studentProvider,
                                  chatRoomProvider.quickReplies!.values
                                      .elementAt(idx),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: kLightPrimary,
                                    border: Border.all(color: kPrimary),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      chatRoomProvider.quickReplies!.keys
                                          .elementAt(idx),
                                      style: textTheme.bodySmall!.copyWith(
                                        color: kPureWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Form(
                    key: _key,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: kDarkWhite,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (val) {
                                return val != null &&
                                        val.isNotEmpty &&
                                        val != " "
                                    ? null
                                    : "Enter a valid message!";
                              },
                              onSaved: (val) {
                                if (val != null && val.isNotEmpty) {
                                  setState(() => _chat = val);
                                }
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type your message here",
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (_key.currentState != null &&
                                  _key.currentState!.validate()) {
                                _key.currentState!.save();

                                sendMessage(
                                  chatRoomProvider,
                                  studentProvider,
                                  _chat!,
                                );

                                _key.currentState!.reset();
                              }
                            },
                            icon: const Icon(Icons.send),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: chatRoomProvider.promptLoading ? 20 : -100,
              left: (deviceWidth / 2) - 120,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                width: 240,
                decoration: BoxDecoration(
                  color: kPrimary,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7,
                      spreadRadius: 5,
                      offset: const Offset(2, 2),
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ],
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Generating Response...",
                      style: TextStyle(
                        fontSize: 16,
                        color: kWhite,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: kWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              right: _showScrollToBottomIndicator ? 20 : -50,
              bottom: 80,
              duration: const Duration(milliseconds: 300),
              child: AnimatedOpacity(
                opacity: _showScrollToBottomIndicator ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: kWhite,
                  child: IconButton(
                    onPressed: () {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOutCubic,
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_downward_rounded,
                      color: kPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendMessage(ChatRoomProvider chatRoomProvider,
      StudentProvider studentProvider, String prompt) async {
    chatRoomProvider.askOstello(
      prompt,
      studentProvider.student.firstName!,
      "ostelloai-${studentProvider.student.phoneNumber}",
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    });
  }

  void scrollToBottomIndicator() {
    if (_scrollController.position.pixels <
        (_scrollController.position.maxScrollExtent - 100)) {
      if (_showScrollToBottomIndicator != true) {
        setState(() {
          _showScrollToBottomIndicator = true;
        });
      }
    } else {
      if (_showScrollToBottomIndicator != false) {
        setState(() {
          _showScrollToBottomIndicator = false;
        });
      }
    }
  }
}
