import 'package:flutter/material.dart';
import 'package:news/app/styles/text_styels.dart';

class ArticleCard extends StatelessWidget {
  final String imageUrl;
  final String category;
  final String headline;
  final String source;
  final String timeAgo;
  final VoidCallback? onTap;

  const ArticleCard({
    Key? key,
    required this.imageUrl,
    required this.category,
    required this.headline,
    required this.source,
    required this.timeAgo,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 375;

    bool isValidHttpUrl(String? url) {
      if (url == null || url.trim().isEmpty) return false;
      final cleaned = url.replaceAll('\n', '').replaceAll('\r', '').trim();
      final uri = Uri.tryParse(cleaned);
      return uri != null && (uri.isScheme('http') || uri.isScheme('https'));
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12 * scale),
      child: Container(
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
              child: SizedBox(
                width: 120 * scale,
                height: 100 * scale,
                child: isValidHttpUrl(imageUrl)
                    ? Image.network(
                        imageUrl
                            .replaceAll('\n', '')
                            .replaceAll('\r', '')
                            .trim(),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image),
                        ),
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
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
      ),
    );
  }
}
