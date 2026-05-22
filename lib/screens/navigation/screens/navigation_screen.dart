import 'dart:ui';

import 'package:bookbuddy/utils/app_color.dart';
import 'package:bookbuddy/utils/sizes/font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/screens/home_screen.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/bloc/home_event.dart';
import '../../favorites/screens/favorites_screen.dart';
import '../../search/screens/search_screen.dart';
import '../../search/bloc/search_bloc.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/layout_manager.dart';
import '../bloc/navigation_bloc.dart';
import '../bloc/navigation_event.dart';
import '../bloc/navigation_state.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationBloc()),
        BlocProvider(create: (_) => HomeBloc()..add(FetchBooksEvent())),
        BlocProvider(create: (_) => SearchBloc()),
      ],
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          Widget body;
          switch (state.currentTab) {
            case AppTab.home:
              body = const HomeScreen();
              break;
            case AppTab.search:
              body = const SearchScreen();
              break;
            case AppTab.favorites:
              body = const FavoritesScreen();
              break;
          }
          return LayoutManager(
            phoneLayout: Builder(
              builder: (context) => Scaffold(
                body: body,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius * 5),
                  ),
                  child: const Icon(Icons.search),
                  onPressed: () => context.read<NavigationBloc>().add(
                    const SelectTabEvent(AppTab.search),
                  ),
                ),
                extendBody: true,
                bottomNavigationBar: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(Dimensions.radius * 3),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: BottomAppBar(
                      shape: const CircularNotchedRectangle(),
                      notchMargin: 10,
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      height: Dimensions.heightSize * 6,
                      color: AppColors.white.withValues(alpha: 0.05),
                      surfaceTintColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: Icon(
                                    Icons.home,
                                    color:
                                        context
                                                .read<NavigationBloc>()
                                                .state
                                                .currentTab ==
                                            AppTab.home
                                        ? AppColors.primary
                                        : AppColors.white,
                                  ),
                                  onTap: () => context
                                      .read<NavigationBloc>()
                                      .add(const SelectTabEvent(AppTab.home)),
                                ),
                                Text(
                                  "Home",
                                  style: TextStyle(
                                    fontSize: FontSize.labelMedium,
                                    color:
                                        context
                                                .read<NavigationBloc>()
                                                .state
                                                .currentTab ==
                                            AppTab.home
                                        ? AppColors.primary
                                        : AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: Icon(
                                    Icons.favorite,
                                    color:
                                        context
                                                .read<NavigationBloc>()
                                                .state
                                                .currentTab ==
                                            AppTab.favorites
                                        ? AppColors.primary
                                        : AppColors.white,
                                  ),
                                  onTap: () =>
                                      context.read<NavigationBloc>().add(
                                        const SelectTabEvent(AppTab.favorites),
                                      ),
                                ),
                                Text(
                                  "Favourite",
                                  style: TextStyle(
                                    fontSize: FontSize.labelMedium,
                                    color:
                                        context
                                                .read<NavigationBloc>()
                                                .state
                                                .currentTab ==
                                            AppTab.favorites
                                        ? AppColors.primary
                                        : AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
