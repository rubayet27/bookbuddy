part of 'home_screen.dart';

class HomePhoneScreen extends StatefulWidget {
  const HomePhoneScreen({super.key});

  @override
  State<HomePhoneScreen> createState() => _HomePhoneScreenState();
}

class _HomePhoneScreenState extends State<HomePhoneScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<HomeBloc>().add(LoadMoreBooksEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStatus.failure &&
              state.appException != null) {
            ErrorBottomSheet.show(
              context,
              exception: state.appException!,
              onRetry: () {
                context.read<HomeBloc>().add(FetchBooksEvent());
              },
            );
          }
        },
        builder: (context, state) {
          if (state.status == HomeStatus.initial ||
              (state.status == HomeStatus.loading && state.books.isEmpty)) {
            return const LoadingView();
          }

          if (state.status == HomeStatus.failure && state.books.isEmpty) {
            return ErrorView(
              message: state.errorMessage ?? "Failed to load books",
              onRetry: () {
                context.read<HomeBloc>().add(FetchBooksEvent());
              },
            );
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              context.read<HomeBloc>().add(FetchBooksEvent());
            },
            child: CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const HomeAppBar(),
                _buildBooksGrid(state.books),
                HomeFooter(state: state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBooksGrid(List<BookItem> books) {
    if (books.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Text(
            "No books found",
            style: TextStyle(fontSize: FontSize.bodyLarge),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: Sizes.padding.psym(h: 16, v: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final book = books[index];
          return AnimatedAppear(child: BookCard(book: book));
        }, childCount: books.length),
      ),
    );
  }
}
