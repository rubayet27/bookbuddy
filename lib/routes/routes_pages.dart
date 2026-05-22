part of 'routes_list.dart';

class RoutesPages {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // GoRoute(name: Routes.splash, path: '/'),
      GoRoute(
        name: Routes.root,
        path: '/',
        builder: (context, state) => const NavigationScreen(),
      ),
      GoRoute(
        name: Routes.home,
        path: '/${Routes.home}',
        builder: (context, state) => const HomeScreen(),
      ),

      GoRoute(
        name: Routes.bookDetails,
        path: '/${Routes.bookDetails}/:bookId',
        builder: (context, state) {
          final bookId = state.pathParameters['bookId']!;
          return BlocProvider(
            create: (_) =>
                BookDetailsBloc()..add(FetchBookDetailsEvent(bookId)),
            child: const BookDetailsScreen(),
          );
        },
      ),

      GoRoute(
        name: Routes.favorites,
        path: '/${Routes.favorites}',
        // FavoritesBloc is app-level — no BlocProvider needed here.
        builder: (context, state) => const FavoritesScreen(),
      ),

      // for bloc bindings

      // GoRoute(
      //   name: Routes.home,
      //   path: "/${Routes.home}",
      //   builder: (context, state) {
      //     return MultiBlocProvider(
      //       providers: [
      //         BlocProvider(create: (_) => HomeBloc()),
      //         BlocProvider(create: (_) => BannerBloc()),
      //       ],
      //       child: const HomePage(),
      //     );
      //   },
      // ),
    ],
  );
}
