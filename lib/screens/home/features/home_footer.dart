import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_color.dart';
import '../../../utils/sizes/font_size.dart';
import '../../../utils/sizes/sizes.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_states.dart';

class HomeFooter extends StatelessWidget {
  final HomeState state;

  const HomeFooter({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: Sizes.padding.all(24),
        child: Center(
          child: Builder(
            builder: (context) {
              if (state.status == HomeStatus.loadingMore) {
                return const CircularProgressIndicator(
                  color: AppColors.primary,
                );
              }
              if (state.hasReachedMax && state.books.isNotEmpty) {
                return Text(
                  "You've caught up!",
                  style: TextStyle(fontSize: FontSize.bodySmall),
                );
              }
              if (state.status == HomeStatus.failure &&
                  state.books.isNotEmpty) {
                return Column(
                  children: [
                    Text(
                      "Error loading more books",
                      style: TextStyle(
                        color: AppColors.error,
                        fontSize: FontSize.bodySmall,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.white,
                      ),
                      onPressed: () {
                        context.read<HomeBloc>().add(LoadMoreBooksEvent());
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
