import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/error_bottom_sheet.dart';
import '../../../utils/app_color.dart';
import '../../../utils/layout_manager.dart';
import '../../../utils/sizes/font_size.dart';
import '../../../utils/sizes/sizes.dart';
import '../../home/features/error_view.dart';
import '../../home/features/image_placeholder.dart';
import '../../home/features/loading_view.dart';
import '../bloc/book_details_bloc.dart';
import '../bloc/book_details_event.dart';
import '../bloc/book_details_state.dart';
import '../../favorites/bloc/favorites_bloc.dart';
import '../../favorites/bloc/favorites_event.dart';
import '../../favorites/bloc/favorites_state.dart';

part 'book_details_phone_screen.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutManager(phoneLayout: BookDetailsPhoneScreen());
  }
}
