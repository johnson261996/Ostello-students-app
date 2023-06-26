import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/mentor_provider.dart';

class MentorCard extends StatelessWidget {
  final int index;

  const MentorCard({
    Key? key,
    required this.index,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final mentor = context.read<MentorProvider>().mentors[index];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.purple,
        image: DecorationImage(
          image: AssetImage(
            "assets/images/mentor/mentor_card_bg_image_${index % 2}.png",
          ),
          fit: BoxFit.fill,
        ),
      ),
      constraints: const BoxConstraints(
        minWidth: 140,
        maxWidth: 170,
        minHeight: 150,
        maxHeight: 250,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mentor.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                if (mentor.description != null)
                  Text(
                    mentor.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            right: -20,
            bottom: -20,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              child: Hero(
                tag: "mentor_avatar_$index",
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: FastCachedImageProvider(mentor.avatar!.url),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                // progressIndicatorBuilder: (ctx, url, downloadProgress) =>
                //     CircularProgressIndicator(
                //   value: downloadProgress.progress,
                // ),
                // errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
