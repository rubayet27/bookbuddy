import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/animated_appear.dart';
import '../../../core/widgets/error_bottom_sheet.dart';
import '../../../utils/app_color.dart';
import '../../../utils/layout_manager.dart';
import '../../../utils/sizes/font_size.dart';
import '../../../utils/sizes/sizes.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_states.dart';
import '../features/book_card.dart';
import '../features/error_view.dart';
import '../features/home_app_bar.dart';
import '../features/home_footer.dart';
import '../features/loading_view.dart';
import '../model/home_model.dart';

part 'home_phone_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutManager(phoneLayout: HomePhoneScreen());
  }
}
