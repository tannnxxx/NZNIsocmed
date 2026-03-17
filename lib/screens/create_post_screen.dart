import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  File? image;
  final caption = TextEditingController();
  final location = TextEditingController();

  Future pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Custom Text Colors para mas madaling mabasa
    final primaryTextColor = isDark ? Colors.white : Colors.blueGrey.shade900;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.blueGrey.shade600;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryTextColor), // Back button color
        title: Text(
          "New Post",
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: primaryTextColor // Siguradong kita ang title
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: image == null ? null : () {
              // Upload Logic
            },
            child: Text(
              "Share",
              style: TextStyle(
                color: image == null ? Colors.grey : Colors.blueAccent,
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // IMAGE PICKER AREA
            GestureDetector(
              onTap: pickImage,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1A1D23) : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isDark ? Colors.white10 : Colors.grey.shade300,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ]
                ),
                child: image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.file(image!, fit: BoxFit.cover),
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add_a_photo_rounded,
                          size: 40, color: Colors.blueAccent),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Tap to select a photo",
                      style: TextStyle(
                        color: secondaryTextColor, // Mas matingkad na kulay
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // INPUT FIELDS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildModernTextField(
                    controller: caption,
                    label: "Write a caption...",
                    icon: Icons.notes_rounded,
                    isDark: isDark,
                    maxLines: 4,
                    textColor: primaryTextColor,
                    hintColor: secondaryTextColor,
                  ),

                  const SizedBox(height: 20),

                  _buildModernTextField(
                    controller: location,
                    label: "Add location",
                    icon: Icons.location_on_rounded,
                    isDark: isDark,
                    textColor: primaryTextColor,
                    hintColor: secondaryTextColor,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isDark,
    required Color textColor,
    required Color hintColor,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1D23) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blueAccent, size: 22),
          hintText: label,
          hintStyle: TextStyle(color: hintColor.withOpacity(0.6), fontSize: 15),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          border: InputBorder.none,
        ),
      ),
    );
  }
}