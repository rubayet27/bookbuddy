import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/sizes/font_size.dart';
import '../../../utils/sizes/sizes.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 130,
      floating: false,
      pinned: true,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final top = constraints.biggest.height;
          final isCollapsed = top < 120;
          return FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(
              left: Sizes.padding.all(20).left,
              bottom: Sizes.padding.all(16).bottom,
            ),
            title: AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: isCollapsed
                  ? Text(
                      "BookBuddy",
                      key: const ValueKey('collapsed_title'),
                      style: TextStyle(
                        fontSize: FontSize.titleLarge,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    )
                  : Column(
                      key: const ValueKey('expanded_title'),
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_getGreeting()} 👋',
                          style: TextStyle(
                            fontSize: FontSize.titleMedium,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'What would you like to read today?',
                          style: TextStyle(
                            fontSize: FontSize
                                .bodySmall, // Use a smaller size for the subtitle
                            fontWeight: FontWeight.normal,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
            ),
            background: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.background],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                // Decorative background patterns
                Positioned(
                  top: -20,
                  right: -20,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.08),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
