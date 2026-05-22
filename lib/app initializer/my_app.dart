import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/favorites/bloc/favorites_bloc.dart';
import '../screens/favorites/bloc/favorites_event.dart';
import '../core/repository/favorites_repository.dart';
import '../routes/routes_list.dart';
import '../utils/theme_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          FavoritesBloc(FavoritesRepository())..add(LoadFavoritesEvent()),
      child: MaterialApp.router(
        title: 'BookBuddy',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: RoutesPages.router,
      ),
    );
  }
}
