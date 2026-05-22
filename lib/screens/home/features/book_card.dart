import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/app_color.dart';
import '../../favorites/bloc/favorites_bloc.dart';
import '../../favorites/bloc/favorites_event.dart';
import '../../favorites/bloc/favorites_state.dart';

import '../../../routes/routes_list.dart';
import '../../../utils/sizes/border_radius.dart';
import '../../../utils/sizes/font_size.dart';
import '../../../utils/sizes/sizes.dart';
import '../model/home_model.dart';
import 'image_placeholder.dart';

class BookCard extends StatelessWidget {
  final BookItem book;
  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final volumeInfo = book.volumeInfo;
    final title = volumeInfo?.title ?? "Untitled";
    final authors = volumeInfo?.authors.join(", ") ?? "Unknown Author";
    final thumbnailUrl = volumeInfo?.imageLinks?.thumbnail;

    return GestureDetector(
      onTap: () {
        final id = book.id;
        if (id == null) return;
        context.pushNamed(Routes.bookDetails, pathParameters: {'bookId': id});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.05),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: thumbnailUrl != null
                          ? Image.network(
                              thumbnailUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const ImagePlaceholder();
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primary,
                                        strokeWidth: 2,
                                      ),
                                    );
                                  },
                            )
                          : const ImagePlaceholder(),
                    ),

                    Positioned(
                      top: 8,
                      right: 8,
                      child: BlocBuilder<FavoritesBloc, FavoritesState>(
                        builder: (context, state) {
                          final isFavorite = state.favoriteIds.contains(
                            book.id,
                          );
                          return GestureDetector(
                            onTap: () {
                              context.read<FavoritesBloc>().add(
                                ToggleFavoriteEvent(book),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.background.withValues(alpha: 0.6),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 20,
                                color: isFavorite
                                    ? AppColors.error
                                    : AppColors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: Sizes.padding.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: FontSize.titleSmall,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      authors,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: FontSize.bodySmall),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
