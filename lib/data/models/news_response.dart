class NewsResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;

  NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    final articlesJson = json['articles'] as List<dynamic>? ?? const [];
    return NewsResponse(
      status: (json['status'] ?? '').toString(),
      totalResults: (json['totalResults'] is int)
          ? json['totalResults'] as int
          : int.tryParse('${json['totalResults']}') ?? 0,
      articles: articlesJson
          .map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'totalResults': totalResults,
    'articles': articles.map((e) => e.toJson()).toList(),
  };
}

class Article {
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    DateTime? published;
    final rawPublished = json['publishedAt'];
    if (rawPublished is String) {
      published = DateTime.tryParse(rawPublished);
    }
    return Article(
      source: json['source'] is Map<String, dynamic>
          ? Source.fromJson(json['source'] as Map<String, dynamic>)
          : null,
      author: _asString(json['author']),
      title: _asString(json['title']),
      description: _asString(json['description']),
      url: _asString(json['url']),
      urlToImage: _asString(json['urlToImage']),
      publishedAt: published,
      content: _asString(json['content']),
    );
  }

  Map<String, dynamic> toJson() => {
    'source': source?.toJson(),
    'author': author,
    'title': title,
    'description': description,
    'url': url,
    'urlToImage': urlToImage,
    'publishedAt': publishedAt?.toIso8601String(),
    'content': content,
  };
}

class Source {
  final String? id;
  final String? name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) =>
      Source(id: _asString(json['id']), name: _asString(json['name']));

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

String? _asString(dynamic value) {
  if (value == null) return null;
  return value.toString();
}
