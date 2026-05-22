part of 'search_screen.dart';

class SearchPhoneScreen extends StatefulWidget {
  const SearchPhoneScreen({super.key});

  @override
  State<SearchPhoneScreen> createState() => _SearchPhoneScreenState();
}

class _SearchPhoneScreenState extends State<SearchPhoneScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<SearchBloc>().add(
        LoadMoreSearchResultsEvent(_searchController.text.trim()),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), () {
      if (query.trim().isNotEmpty) {
        context.read<SearchBloc>().add(FetchSearchResultsEvent(query.trim()));
      } else {
        context.read<SearchBloc>().add(FetchSearchResultsEvent(''));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          title: TextField(
            controller: _searchController,
            autofocus: true,
            style: const TextStyle(color: AppColors.white, fontSize: 16),
            decoration: const InputDecoration(
              hintText: 'Search for books...',
              hintStyle: TextStyle(color: AppColors.textSecondary),
              border: InputBorder.none,
            ),
            textInputAction: TextInputAction.search,
            onChanged: _onSearchChanged,
            onSubmitted: (query) {
              _debounce?.cancel();
              if (query.trim().isNotEmpty) {
                context.read<SearchBloc>().add(
                  FetchSearchResultsEvent(query.trim()),
                );
              }
            },
          ),
          iconTheme: const IconThemeData(color: AppColors.white),
        ),
        body: BlocConsumer<SearchBloc, SearchState>(
          listener: (context, state) {
            if (state.status == SearchStatus.failure &&
                state.appException != null) {
              ErrorBottomSheet.show(
                context,
                exception: state.appException!,
                onRetry: () {
                  context.read<SearchBloc>().add(
                    FetchSearchResultsEvent(_searchController.text.trim()),
                  );
                },
              );
            }
          },
          builder: (context, state) {
            if (state.status == SearchStatus.initial) {
              return Center(
                child: Text(
                  'Type to search for books...',
                  style: TextStyle(fontSize: FontSize.bodyLarge),
                ),
              );
            }

            if (state.status == SearchStatus.loading && state.books.isEmpty) {
              return const LoadingView();
            }

            if (state.status == SearchStatus.failure && state.books.isEmpty) {
              return ErrorView(
                message: state.errorMessage ?? "Failed to search books",
                onRetry: () {
                  context.read<SearchBloc>().add(
                    FetchSearchResultsEvent(_searchController.text.trim()),
                  );
                },
              );
            }

            return CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                _buildBooksGrid(state.books),
                if (state.status == SearchStatus.loadingMore)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
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
          childAspectRatio: 0.58,
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
