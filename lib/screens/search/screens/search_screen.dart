import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/animated_appear.dart';
import '../../../core/widgets/error_bottom_sheet.dart';
import '../../../utils/app_color.dart';
import '../../../utils/layout_manager.dart';
import '../../../utils/sizes/font_size.dart';
import '../../../utils/sizes/sizes.dart';
import '../../home/features/book_card.dart';
import '../../home/features/error_view.dart';
import '../../home/features/loading_view.dart';
import '../../home/model/home_model.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_states.dart';

part 'search_phone_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutManager(phoneLayout: const SearchPhoneScreen());
  }
}
