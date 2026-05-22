import '../../../core/api base/api_helper/api_exception.dart';
import '../../home/model/home_model.dart';

enum SearchStatus { initial, loading, loadingMore, success, failure }

class SearchState {
  final SearchStatus status;
  final List<BookItem> books;
  final int startIndex;
  final bool hasReachedMax;
  final String? errorMessage;
  final AppException? appException;
  final String currentQuery;

  const SearchState({
    required this.status,
    this.books = const <BookItem>[],
    this.startIndex = 0,
    this.hasReachedMax = false,
    this.errorMessage,
    this.appException,
    this.currentQuery = '',
  });

  factory SearchState.initial() {
    return const SearchState(status: SearchStatus.initial);
  }

  SearchState copyWith({
    SearchStatus? status,
    List<BookItem>? books,
    int? startIndex,
    bool? hasReachedMax,
    String? errorMessage,
    AppException? appException,
    String? currentQuery,
  }) {
    return SearchState(
      status: status ?? this.status,
      books: books ?? this.books,
      startIndex: startIndex ?? this.startIndex,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      appException: appException ?? this.appException,
      currentQuery: currentQuery ?? this.currentQuery,
    );
  }
}
