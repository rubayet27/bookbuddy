part of 'favorites_screen.dart';

class FavoritesPhoneScreen extends StatelessWidget {
  const FavoritesPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              const FavoritesAppBar(),
              state.favorites.isEmpty
                  ? const FavoritesEmptyState()
                  : _buildFavoritesGrid(
                      state.favorites.map((f) => f.toBookItem()).toList(),
                    ),
            ],
          );
        },
      ),
    );
  }

  SliverPadding _buildFavoritesGrid(List<BookItem> books) {
    return SliverPadding(
      padding: Sizes.padding.psym(h: 16, v: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.58,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) =>
              AnimatedAppear(child: BookCard(book: books[index])),
          childCount: books.length,
        ),
      ),
    );
  }
}
