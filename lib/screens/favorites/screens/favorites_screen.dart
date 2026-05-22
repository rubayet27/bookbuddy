import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/animated_appear.dart';
import '../../../screens/home/features/book_card.dart';
import '../../../screens/home/model/home_model.dart';
import '../../../utils/sizes/sizes.dart';
import '../../../utils/layout_manager.dart';
import '../bloc/favorites_bloc.dart';
import '../bloc/favorites_state.dart';
import '../features/favorites_app_bar.dart';
import '../features/favorites_empty_state.dart';

part 'favorites_phone_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutManager(phoneLayout: FavoritesPhoneScreen());
  }
}
