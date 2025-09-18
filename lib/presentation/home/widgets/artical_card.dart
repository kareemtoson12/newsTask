import 'package:flutter/material.dart';
import 'package:news/app/styles/text_styels.dart';

class ArticleCard extends StatelessWidget {
  final String imageUrl;
  final String category;
  final String headline;
  final String source;
  final String timeAgo;

  const ArticleCard({
    Key? key,
    required this.imageUrl,
    required this.category,
    required this.headline,
    required this.source,
    required this.timeAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 375;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scale),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8 * scale,
            offset: Offset(0, 2 * scale),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12 * scale),
              bottomLeft: Radius.circular(12 * scale),
            ),
            child: Container(
              width: 120 * scale,
              height: 100 * scale,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category
                  Text(category, style: AppTextStyles.category(context)),
                  SizedBox(height: 6 * scale),

                  // Headline
                  Text(
                    headline,
                    style: AppTextStyles.headline(context),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12 * scale),

                  // Source and Time
                  Row(
                    children: [
                      // Example source logo placeholder
                      SizedBox(width: 6 * scale),

                      Expanded(
                        child: Text(
                          source,
                          style: AppTextStyles.source(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8 * scale),

                      Icon(
                        Icons.access_time,
                        size: 12 * scale,
                        color: Colors.grey[500],
                      ),
                      SizedBox(width: 4 * scale),

                      Text(timeAgo, style: AppTextStyles.time(context)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
