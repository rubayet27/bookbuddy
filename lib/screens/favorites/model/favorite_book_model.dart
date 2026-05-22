import 'package:hive/hive.dart';

import '../../home/model/home_model.dart';

part 'favorite_book_adapter.dart';

class FavoriteBookModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String authors;

  @HiveField(3)
  final String? thumbnail;

  @HiveField(4)
  final String? publishedDate;

  FavoriteBookModel({
    required this.id,
    required this.title,
    required this.authors,
    this.thumbnail,
    this.publishedDate,
  });

  factory FavoriteBookModel.fromBookItem(BookItem item) {
    final info = item.volumeInfo;
    return FavoriteBookModel(
      id: item.id ?? '',
      title: info?.title ?? 'Untitled',
      authors: info?.authors.join(', ') ?? 'Unknown Author',
      thumbnail: info?.imageLinks?.thumbnail,
      publishedDate: info?.publishedDate,
    );
  }

  BookItem toBookItem() {
    return BookItem(
      id: id,
      volumeInfo: VolumeInfo(
        title: title,
        authors: authors.split(', '),
        publishedDate: publishedDate,
        imageLinks: thumbnail != null ? ImageLinks(thumbnail: thumbnail) : null,
      ),
    );
  }
}
