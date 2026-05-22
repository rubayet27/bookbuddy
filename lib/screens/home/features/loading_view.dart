import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primary),
          SizedBox(height: 16),
          Text(
            "Fetching curated books...",
            style: TextStyle(fontSize: 14, decoration: TextDecoration.none),
          ),
        ],
      ),
    );
  }
}
