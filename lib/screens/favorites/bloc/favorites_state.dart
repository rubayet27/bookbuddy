import '../model/favorite_book_model.dart';

class FavoritesState {
  final List<FavoriteBookModel> favorites;

  final Set<String> favoriteIds;

  const FavoritesState({required this.favorites, required this.favoriteIds});

  factory FavoritesState.initial() {
    return const FavoritesState(favorites: [], favoriteIds: {});
  }

  FavoritesState copyWith({
    List<FavoriteBookModel>? favorites,
    Set<String>? favoriteIds,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }

  /// Whether the book with [id] is currently a favorite.
  bool isFavorite(String id) => favoriteIds.contains(id);
}
