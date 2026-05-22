import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/api base/api_endpoint/api_endpoints.dart';
import '../../../core/api base/api_request/api_call.dart';
import '../../../flavor_config.dart';
import '../../home/model/home_model.dart';
import 'book_details_event.dart';
import 'book_details_state.dart';

class BookDetailsBloc extends Bloc<BookDetailsEvent, BookDetailsState> {
  BookDetailsBloc() : super(BookDetailsState.initial()) {
    on<FetchBookDetailsEvent>((event, emit) async {
      await ApiCall.call<BookItem>(
        path: ApiEndpoints.bookDetails(event.id),
        method: ApiMethodType.get,
        queryParams: {'key': FlavorConfig.apiKey},
        fromJson: BookItem.fromJson,
        isLoading: (loading) {
          if (loading) {
            emit(state.copyWith(status: BookDetailsStatus.loading));
          }
        },
        onSuccess: (result) {
          emit(
            state.copyWith(
              status: BookDetailsStatus.success,
              book: result,
              errorMessage: null,
              appException: null,
            ),
          );
        },
        onError: (error) {
          emit(
            state.copyWith(
              status: BookDetailsStatus.failure,
              errorMessage: error.message,
              appException: error,
            ),
          );
        },
      );
    });
  }
}
