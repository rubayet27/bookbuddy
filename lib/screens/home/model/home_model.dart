class BookModel {
  final String? kind;
  final int? totalItems;
  final List<BookItem> items;

  BookModel({this.kind, this.totalItems, required this.items});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List?;
    List<BookItem> bookItems = list != null
        ? list.map((i) => BookItem.fromJson(i as Map<String, dynamic>)).toList()
        : [];
    return BookModel(
      kind: json['kind'] as String?,
      totalItems: json['totalItems'] as int?,
      items: bookItems,
    );
  }
}

class BookItem {
  final String? kind;
  final String? id;
  final String? etag;
  final String? selfLink;
  final VolumeInfo? volumeInfo;

  BookItem({this.kind, this.id, this.etag, this.selfLink, this.volumeInfo});

  factory BookItem.fromJson(Map<String, dynamic> json) {
    return BookItem(
      kind: json['kind'] as String?,
      id: json['id'] as String?,
      etag: json['etag'] as String?,
      selfLink: json['selfLink'] as String?,
      volumeInfo: json['volumeInfo'] != null
          ? VolumeInfo.fromJson(json['volumeInfo'] as Map<String, dynamic>)
          : null,
    );
  }
}

class VolumeInfo {
  final String? title;
  final List<String> authors;
  final String? publishedDate;
  final String? description;
  final ImageLinks? imageLinks;

  VolumeInfo({
    this.title,
    required this.authors,
    this.publishedDate,
    this.description,
    this.imageLinks,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> json) {
    var authorsList = json['authors'] as List?;
    List<String> parsedAuthors = authorsList != null
        ? authorsList.map((a) => a.toString()).toList()
        : [];
    return VolumeInfo(
      title: json['title'] as String?,
      authors: parsedAuthors,
      publishedDate: json['publishedDate'] as String?,
      description: json['description'] as String?,
      imageLinks: json['imageLinks'] != null
          ? ImageLinks.fromJson(json['imageLinks'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ImageLinks {
  final String? smallThumbnail;
  final String? thumbnail;

  ImageLinks({this.smallThumbnail, this.thumbnail});

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    // Google Books API returns http links for cover images, which might fail or be blocked.
    // Replace http:// with https:// for better compatibility and security.
    String? getSecureUrl(String? url) {
      if (url == null) return null;
      if (url.startsWith('http://')) {
        return url.replaceFirst('http://', 'https://');
      }
      return url;
    }

    return ImageLinks(
      smallThumbnail: getSecureUrl(json['smallThumbnail'] as String?),
      thumbnail: getSecureUrl(json['thumbnail'] as String?),
    );
  }
}
