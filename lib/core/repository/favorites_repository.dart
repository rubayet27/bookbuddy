import 'package:hive/hive.dart';

import '../../screens/favorites/model/favorite_book_model.dart';

class FavoritesRepository {
  static const String _boxName = 'favorites';

  Box<FavoriteBookModel> get _box => Hive.box<FavoriteBookModel>(_boxName);

  /// Returns all favorited books in insertion order.
  List<FavoriteBookModel> getAll() => _box.values.toList();

  /// Returns true if the book with [id] is already favorited.
  bool isFavorite(String id) => _box.containsKey(id);

  /// Saves a book as a favorite using its [id] as the Hive key.
  Future<void> addFavorite(FavoriteBookModel book) async {
    await _box.put(book.id, book);
  }

  /// Removes a favorited book by its [id].
  Future<void> removeFavorite(String id) async {
    await _box.delete(id);
  }
}
