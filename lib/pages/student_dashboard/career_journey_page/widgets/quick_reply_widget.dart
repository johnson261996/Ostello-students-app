import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/quick_reply.dart';
import '../../../../providers/chat_room_provider.dart';
import '../../../../utils/colours.dart';

class QuickReplyWidget extends StatefulWidget {
  final QuickReply quickReply;

  const QuickReplyWidget({
    Key? key,
    required this.quickReply,
  }) : super(key: key);

  @override
  State<QuickReplyWidget> createState() => _QuickReplyWidgetState();
}

class _QuickReplyWidgetState extends State<QuickReplyWidget> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChatRoomProvider>();
    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: const BoxDecoration(
              color: kReceivedChatCardColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.zero,
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
              ),
            ),
            constraints: const BoxConstraints(
              maxWidth: 200,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.quickReply.sender,
                      style: textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.quickReply.message,
                      style: textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  widget.quickReply.timeStamp,
                  style: textTheme.bodySmall!.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.zero,
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            constraints: const BoxConstraints(
              maxWidth: 200,
            ),
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                for (int i = 0; i < widget.quickReply.quickReplies.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: kWhite,
                      border: Border.all(color: const Color(0xFFEDF2F6)),
                    ),
                    child: InkWell(
                      onTap: () => model.setChatQuickReply =
                          widget.quickReply.quickReplies[i],
                      child: Text(
                        widget.quickReply.quickReplies[i],
                        style: textTheme.bodySmall!.copyWith(
                          color: kBlue,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
