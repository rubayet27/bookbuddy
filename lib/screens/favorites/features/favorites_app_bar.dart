import 'package:flutter/material.dart';
import '../../../../utils/sizes/sizes.dart';
import '../../../utils/app_color.dart';
import '../../../utils/sizes/font_size.dart';

class FavoritesAppBar extends StatelessWidget {
  const FavoritesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 100,
      pinned: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(
          left: Sizes.padding.all(24).left,
          bottom: Sizes.padding.all(16).bottom,
        ),
        title: Text(
          'My Favorites',
          style: TextStyle(
            fontSize: FontSize.titleLarge,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: AppColors.white,
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.background],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }
}
