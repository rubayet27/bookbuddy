import '../../home/model/home_model.dart';

sealed class FavoritesEvent {}

class LoadFavoritesEvent extends FavoritesEvent {}

class ToggleFavoriteEvent extends FavoritesEvent {
  final BookItem book;
  ToggleFavoriteEvent(this.book);
}
