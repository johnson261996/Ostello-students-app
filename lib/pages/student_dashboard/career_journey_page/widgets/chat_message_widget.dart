import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../../models/chat.dart';
import '../../../../utils/colours.dart';

class ChatMessage extends StatefulWidget {
  final Chat chat;

  const ChatMessage({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: widget.chat.isLeft ? Alignment.topLeft : Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color:
              widget.chat.isLeft ? kReceivedChatCardColor : kSentChatCardColor,
          borderRadius: BorderRadius.only(
            topRight:
                widget.chat.isLeft ? const Radius.circular(20) : Radius.zero,
            topLeft:
                !widget.chat.isLeft ? const Radius.circular(20) : Radius.zero,
            bottomLeft: const Radius.circular(20),
            bottomRight: const Radius.circular(20),
          ),
        ),
        constraints: const BoxConstraints(
          minWidth: 60,
          maxWidth: 250,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: widget.chat.isLeft
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            MarkdownBody(data: widget.chat.message),
            const SizedBox(height: 10),
            Text(
              widget.chat.timeStamp,
              style: textTheme.bodySmall!.copyWith(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
