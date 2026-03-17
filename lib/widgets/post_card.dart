import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/travel_post.dart';
import '../providers/post_provider.dart';

class PostCard extends StatelessWidget {
  final TravelPost post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostProvider>(context);

    // Kukunin natin kung Dark o Light ang mode para sa adaptive colors
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      // dynamic color: gagamit ng cardColor mula sa theme (main.dart)
      color: Theme.of(context).cardColor,

      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),

      // Mas aesthetic na shadow: walang shadow sa dark, konting shadow sa light
      elevation: isDark ? 0 : 2,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        // Lalagyan natin ng manipis na border para mas malinis tingnan sa light mode
        side: isDark
            ? BorderSide.none
            : BorderSide(color: Colors.grey.shade200, width: 1),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// USER HEADER
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.profilePic),
            ),
            title: Text(
              post.username,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                // Adaptive text color
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            subtitle: Text(
              post.location,
              style: TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
            trailing: Icon(
              Icons.more_horiz_rounded,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),

          /// POST IMAGE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                post.mainImage,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// ACTION BUTTONS
          Row(
            children: [
              IconButton(
                icon: Icon(
                  post.isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: post.isLiked
                      ? Colors.redAccent
                      : (isDark ? Colors.white : Colors.black87),
                ),
                onPressed: () {
                  provider.toggleLike(post);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.send_outlined,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                onPressed: () {},
              ),
            ],
          ),

          /// LIKES
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "${post.likes} likes",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ),

          /// DESCRIPTION
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: RichText(
              text: TextSpan(
                // Inalis ang hardcoded Colors.white
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: "${post.username} ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: post.description,
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}