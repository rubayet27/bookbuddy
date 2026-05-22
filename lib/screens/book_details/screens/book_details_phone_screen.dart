part of 'book_details_screen.dart';

class BookDetailsPhoneScreen extends StatelessWidget {
  const BookDetailsPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocConsumer<BookDetailsBloc, BookDetailsState>(
          listener: (context, state) {
            if (state.status == BookDetailsStatus.failure &&
                state.appException != null) {
              ErrorBottomSheet.show(
                context,
                exception: state.appException!,
                onRetry: () {
                  if (state.book != null) {
                    context.read<BookDetailsBloc>().add(
                      FetchBookDetailsEvent(state.book!.id ?? ''),
                    );
                  } else {
                    context.pop();
                  }
                },
              );
            }
          },
          builder: (context, state) {
            if (state.status == BookDetailsStatus.initial ||
                state.status == BookDetailsStatus.loading) {
              return const LoadingView();
            }

            if (state.status == BookDetailsStatus.failure ||
                state.book == null) {
              return ErrorView(
                message: state.errorMessage ?? "Failed to load book details",
                onRetry: () {
                  context.pop();
                },
              );
            }

            final book = state.book!;
            final volumeInfo = book.volumeInfo;
            final title = volumeInfo?.title ?? "Untitled";
            final authors = volumeInfo?.authors.join(", ") ?? "Unknown Author";
            final description =
                volumeInfo?.description ?? "No description available.";
            final publishedDate =
                volumeInfo?.publishedDate ?? "Unknown Publish Date";
            final imageUrl = volumeInfo?.imageLinks?.thumbnail;

            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: 350,
                  pinned: true,
                  elevation: 0,
                  automaticallyImplyLeading: false,

                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Positioned.fill(
                          child: imageUrl != null
                              ? Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) =>
                                      const ImagePlaceholder(),
                                )
                              : const ImagePlaceholder(),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: Sizes.padding.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: FontSize.headlineSmall,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              authors,
                              style: TextStyle(
                                fontSize: FontSize.titleMedium,
                                color: AppColors.primary, // Violet-500
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            BlocBuilder<FavoritesBloc, FavoritesState>(
                              builder: (context, favoritesState) {
                                final isFavorite = favoritesState.favoriteIds
                                    .contains(book.id);
                                return Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.white.withValues(
                                      alpha: 0.05,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavorite
                                          ? AppColors.error
                                          : AppColors.white,
                                    ),
                                    onPressed: () {
                                      context.read<FavoritesBloc>().add(
                                        ToggleFavoriteEvent(book),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "First published: $publishedDate",
                          style: TextStyle(fontSize: FontSize.bodySmall),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: FontSize.titleMedium,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: FontSize.bodyMedium,
                            color: AppColors.textSecondary, // Slate-300
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
