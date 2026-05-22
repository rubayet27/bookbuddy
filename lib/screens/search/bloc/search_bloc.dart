import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/api base/api_endpoint/api_endpoints.dart';
import '../../../core/api base/api_request/api_call.dart';
import '../../../flavor_config.dart';
import '../../home/model/home_model.dart';
import 'search_event.dart';
import 'search_states.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState.initial()) {
    on<FetchSearchResultsEvent>((event, emit) async {
      if (event.query.isEmpty) {
        emit(SearchState.initial());
        return;
      }

      emit(
        state.copyWith(
          status: SearchStatus.loading,
          currentQuery: event.query,
          books: [],
          startIndex: 0,
          hasReachedMax: false,
        ),
      );

      await ApiCall.call<BookModel>(
        path: ApiEndpoints.allList,
        method: ApiMethodType.get,
        queryParams: {
          'q': event.query,
          'startIndex': 0,
          'maxResults': 10,
          'key': FlavorConfig.apiKey,
        },
        fromJson: BookModel.fromJson,
        isLoading: (loading) {},
        onSuccess: (result) {
          emit(
            state.copyWith(
              status: SearchStatus.success,
              books: result.items,
              startIndex: result.items.length,
              hasReachedMax: result.items.length < 10,
              errorMessage: null,
              appException: null,
            ),
          );
        },
        onError: (error) {
          emit(
            state.copyWith(
              status: SearchStatus.failure,
              errorMessage: error.message,
              appException: error,
            ),
          );
        },
      );
    });

    on<LoadMoreSearchResultsEvent>((event, emit) async {
      if (state.status == SearchStatus.loading ||
          state.status == SearchStatus.loadingMore ||
          state.hasReachedMax ||
          state.currentQuery.isEmpty) {
        return;
      }

      emit(state.copyWith(status: SearchStatus.loadingMore));

      await ApiCall.call<BookModel>(
        path: ApiEndpoints.allList,
        method: ApiMethodType.get,
        queryParams: {
          'q': state.currentQuery,
          'startIndex': state.startIndex,
          'maxResults': 10,
          'key': FlavorConfig.apiKey,
        },
        fromJson: BookModel.fromJson,
        isLoading: (loading) {},
        onSuccess: (result) {
          final updatedBooks = [...state.books, ...result.items];
          emit(
            state.copyWith(
              status: SearchStatus.success,
              books: updatedBooks,
              startIndex: state.startIndex + result.items.length,
              hasReachedMax: result.items.length < 10,
              errorMessage: null,
              appException: null,
            ),
          );
        },
        onError: (error) {
          emit(
            state.copyWith(
              status: SearchStatus.failure,
              errorMessage: error.message,
              appException: error,
            ),
          );
        },
      );
    });
  }
}
