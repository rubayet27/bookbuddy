import '../../../core/api base/api_helper/api_exception.dart';
import '../model/home_model.dart';

enum HomeStatus { initial, loading, success, failure, loadingMore }

class HomeState {
  final HomeStatus status;
  final List<BookItem> books;
  final String? errorMessage;
  final AppException? appException;
  final bool hasReachedMax;
  final int startIndex;

  HomeState({
    required this.status,
    required this.books,
    this.errorMessage,
    this.appException,
    required this.hasReachedMax,
    required this.startIndex,
  });

  factory HomeState.initial() {
    return HomeState(
      status: HomeStatus.initial,
      books: [],
      errorMessage: null,
      appException: null,
      hasReachedMax: false,
      startIndex: 0,
    );
  }

  HomeState copyWith({
    HomeStatus? status,
    List<BookItem>? books,
    String? errorMessage,
    AppException? appException,
    bool? hasReachedMax,
    int? startIndex,
  }) {
    return HomeState(
      status: status ?? this.status,
      books: books ?? this.books,
      errorMessage: errorMessage ?? this.errorMessage,
      appException: appException ?? this.appException,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      startIndex: startIndex ?? this.startIndex,
    );
  }
}
