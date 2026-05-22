import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/favorite_book_model.dart';
import '../../../core/repository/favorites_repository.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository _repo;

  FavoritesBloc(this._repo) : super(FavoritesState.initial()) {
    on<LoadFavoritesEvent>(_onLoad);
    on<ToggleFavoriteEvent>(_onToggle);
  }

  void _onLoad(LoadFavoritesEvent event, Emitter<FavoritesState> emit) {
    final all = _repo.getAll();
    emit(
      state.copyWith(
        favorites: all,
        favoriteIds: all.map((f) => f.id).where((id) => id.isNotEmpty).toSet(),
      ),
    );
  }

  Future<void> _onToggle(
    ToggleFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final id = event.book.id ?? '';
    if (id.isEmpty) return;

    if (_repo.isFavorite(id)) {
      await _repo.removeFavorite(id);
    } else {
      await _repo.addFavorite(FavoriteBookModel.fromBookItem(event.book));
    }

    final updated = _repo.getAll();
    emit(
      state.copyWith(
        favorites: updated,
        favoriteIds: updated
            .map((f) => f.id)
            .where((id) => id.isNotEmpty)
            .toSet(),
      ),
    );
  }
}
