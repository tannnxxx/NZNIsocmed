import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';
import '../providers/theme_provider.dart'; // Import ito para sa Dark Mode toggle
import '../widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // Dynamic background color base sa theme
      backgroundColor: isDark ? const Color(0xFF0F1115) : const Color(0xFFF8F9FB),

      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF0F1115) : Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "TravelGram",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 24,
            letterSpacing: -1,
          ),
        ),
        actions: [
          // THEME TOGGLE BUTTON - Minimalist function
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_outlined,
              color: isDark ? Colors.orangeAccent : Colors.black87,
              size: 22,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            color: isDark ? Colors.white : Colors.black87,
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: provider.posts.isEmpty
          ? _buildEmptyState(context, isDark)
          : RefreshIndicator(
        onRefresh: () async {
          // Refresh logic simulation
          await Future.delayed(const Duration(seconds: 1));
        },
        color: Colors.blueAccent,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: provider.posts.length + 1, // +1 para sa Header section
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildHeaderSection(isDark);
            }

            final post = provider.posts[index - 1];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: PostCard(post: post),
            );
          },
        ),
      ),
    );
  }

  // Header Section: Greeting at Story Bar placeholder
  Widget _buildHeaderSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning,",
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                "Explore the World 🌍",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),

        // Horizontal Story Bar Placeholder (Aesthetic Minimalist)
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.blueAccent, Colors.purpleAccent.shade100],
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: isDark ? const Color(0xFF0F1115) : Colors.white, width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      index == 0 ? "You" : "User $index",
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const Divider(height: 30, thickness: 0.5, indent: 20, endIndent: 20),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome_mosaic_outlined,
              size: 80,
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
          const SizedBox(height: 16),
          Text(
            "Your feed is quiet for now",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}