import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/core/utils/widget/bag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stepify/feature/home/ui/widgets/shoe_card.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onMicTap;

  const SearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.onMicTap, required bool isListening,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: "Search sneakers...",
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.mic),
          onPressed: onMicTap, // This will trigger the voice search
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}




class SearchChip extends StatelessWidget {
  final String label;

  const SearchChip({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).primaryColor),
      ),
    );
  }
}



class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
    );
  }
}








class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> recentSearches = ["Nike", "Adidas", "Puma", "Running"];
  final List<String> suggestions = [
    "Air Max",
    "Jordan",
    "Sneaker",
    "Ultra Boost"
  ];
  final List<Map<String, String>> searchResults = [
    {
      "name": "Nike Jordan",
      "price": "\$302.00",
      "imageUrl": "assets/products_images/product6.png"
    },
    {
      "name": "Adidas Runner",
      "price": "\$199.00",
      "imageUrl": "assets/products_images/product2.png"
    },
    {
      "name": "Puma Ultra",
      "price": "\$169.00",
      "imageUrl": "assets/products_images/product4.png"
    },
    {
      "name": "Nike Air Max",
      "price": "\$752.00",
      "imageUrl": "assets/products_images/product5.png"
    },
  ];

  // Speech-to-text controller
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _micStatusText = "Tap the mic to start speaking";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _onMicTap() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          _isListening = true;
          _micStatusText = "Listening... speak now!";
        });
        _showListeningPopup(); // Show the popup
        _speech.listen(
          localeId: 'en_US',
          onResult: (result) {
          setState(() {
            _searchController.text = result.recognizedWords;
          });
        });
      }
    } else {
      _speech.stop();
      setState(() {
        _isListening = false;
        _micStatusText = "Tap the mic to start speaking";
      });
    }
  }

  void _showListeningPopup() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the popup by tapping outside
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: AnimatedWave(),
          ),
        );
      },
    );

    // Close the popup after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pop();
      _speech.stop();
      setState(() {
        _isListening = false;
        _micStatusText = "Tap the mic to start speaking";
      });
    });
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text("Search", style: Theme.of(context).textTheme.bodyLarge),
        backgroundColor: ColorsManager.secondaryColor,
        elevation: 0,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        actions: const [BagWidget()],
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.secondaryColor,
                  shape: const CircleBorder(),
                  fixedSize: Size(30.w, 30.w),
                ),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: ColorsManager.textColor,
                  size: 16,
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            SearchBar(
              controller: _searchController,
              onChanged: (value) {
                // Implement search logic
              },
              onMicTap: _onMicTap, // Pass the mic tap handler
              isListening: _isListening,
            ),
            SizedBox(height: 10.h),
            Text(
              _micStatusText, // Display mic status
              style: TextStyle(
                color: _isListening ? Colors.green : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 20.h),
            const SectionTitle(title: "Suggestions"),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: suggestions.map((s) => SearchChip(label: s)).toList(),
            ),
            SizedBox(height: 20.h),
            const SectionTitle(title: "Recent Searches"),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: recentSearches.map((s) => SearchChip(label: s)).toList(),
            ),
            SizedBox(height: 20.h),
            const SectionTitle(title: "Popular Results"),
            SizedBox(height: 10.h),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(top: 8.h),
                itemCount: searchResults.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final shoe = searchResults[index];
                  return ShoeCard(
                    imageUrl: shoe["imageUrl"]!,
                    name: shoe["name"]!,
                    price: shoe["price"]!,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AnimatedWave extends StatelessWidget {
  const AnimatedWave({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(seconds: 1),
      tween: Tween<double>(begin: 1.0, end: 1.2),
      onEnd: () {},
      builder: (context, double scale, child) {
        return ScaleTransition(
          scale: AlwaysStoppedAnimation(scale),
          child: Icon(
            Icons.mic,
            size: 80.w,
            color: Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }
}