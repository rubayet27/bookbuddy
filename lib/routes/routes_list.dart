import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../screens/book_details/bloc/book_details_bloc.dart';
import '../screens/book_details/bloc/book_details_event.dart';
import '../screens/book_details/screens/book_details_screen.dart';
import '../screens/favorites/screens/favorites_screen.dart';
import '../screens/home/screens/home_screen.dart';

import '../screens/navigation/screens/navigation_screen.dart';

part 'routes_pages.dart';

class Routes {
  static String root = "root";
  static String home = "home";
  static String splash = "splash";
  static String bookDetails = "bookDetails";
  static String favorites = "favorites";
}
