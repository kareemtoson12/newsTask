import 'package:flutter/material.dart';
import 'package:news/data/models/news_response.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailView extends StatelessWidget {
  final Article article;
  const ArticleDetailView({super.key, required this.article});

  Future<void> _openUrl(BuildContext context) async {
    final url = article.url;
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No URL available for this article')),
      );
      return;
    }
    final uri = Uri.tryParse(url);
    if (uri == null || !(uri.isScheme('http') || uri.isScheme('https'))) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid article URL')));
      return;
    }

    final can = await canLaunchUrl(uri);
    if (!can) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No browser available to open the link')),
      );
      return;
    }

    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the article URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.source?.name ?? 'Article')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if ((article.urlToImage ?? '').isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  article.urlToImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              article.title ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              (article.description?.isNotEmpty == true)
                  ? article.description!
                  : (article.content ?? ''),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _openUrl(context),
                icon: const Icon(Icons.open_in_new),
                label: const Text('Open full article'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
