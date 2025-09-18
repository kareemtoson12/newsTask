import 'package:flutter/material.dart';
import 'package:news/presentation/home/widgets/artical_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'All',
      'Business',
      'Entertainment',
      'Health',
      'Science',
      'Sports',
      'Technology',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Image.asset('assets/splash.png', width: 100, height: 70),
                    const Spacer(),
                    const Icon(
                      Icons.notifications_outlined,
                      color: Colors.black,
                    ),
                  ],
                ),
                const SizedBox(height: 35),

                // List of categories
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          categories[index],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 35),

                //A Card-based layout
                ArticleCard(
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROyJaoc4zumv18ADlyU0mOgk6Z-GgKMVuO1g&s',
                  category: 'Business',
                  headline: 'Business',
                  source: 'Business',
                  timeAgo: 'Business',
                ),
                ArticleCard(
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROyJaoc4zumv18ADlyU0mOgk6Z-GgKMVuO1g&s',
                  category: 'Business',
                  headline: 'Business',
                  source: 'Business',
                  timeAgo: 'Business',
                ),
                ArticleCard(
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROyJaoc4zumv18ADlyU0mOgk6Z-GgKMVuO1g&s',
                  category: 'Business',
                  headline: 'Business',
                  source: 'Business',
                  timeAgo: 'Business',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
