import '../../../core/api base/api_helper/api_exception.dart';
import '../../home/model/home_model.dart';

enum BookDetailsStatus { initial, loading, success, failure }

class BookDetailsState {
  final BookDetailsStatus status;
  final BookItem? book;
  final String? errorMessage;
  final AppException? appException;

  BookDetailsState({
    required this.status,
    this.book,
    this.errorMessage,
    this.appException,
  });

  factory BookDetailsState.initial() {
    return BookDetailsState(
      status: BookDetailsStatus.initial,
      book: null,
      errorMessage: null,
      appException: null,
    );
  }

  BookDetailsState copyWith({
    BookDetailsStatus? status,
    BookItem? book,
    String? errorMessage,
    AppException? appException,
  }) {
    return BookDetailsState(
      status: status ?? this.status,
      book: book ?? this.book,
      errorMessage: errorMessage ?? this.errorMessage,
      appException: appException ?? this.appException,
    );
  }
}
