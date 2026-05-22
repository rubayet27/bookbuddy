import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/api base/api_endpoint/api_endpoints.dart';
import '../../../core/api base/api_request/api_call.dart';
import '../../../flavor_config.dart';
import '../model/home_model.dart';
import 'home_event.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<FetchBooksEvent>((event, emit) async {
      await ApiCall.call<BookModel>(
        path: ApiEndpoints.allList,
        method: ApiMethodType.get,
        queryParams: {
          'q': 'a',
          'startIndex': 0,
          'maxResults': 10,
          'key': FlavorConfig.apiKey,
        },
        fromJson: BookModel.fromJson,
        isLoading: (loading) {
          if (loading) {
            emit(state.copyWith(status: HomeStatus.loading));
          }
        },
        onSuccess: (result) {
          emit(
            state.copyWith(
              status: HomeStatus.success,
              books: result.items,
              startIndex: result.items.length,
              hasReachedMax: result.items.length < 10,
              errorMessage: null,
              appException: null,
            ),
          );
        },
        onError: (error) {
          emit(state.copyWith(
            status: HomeStatus.failure,
            errorMessage: error.message,
            appException: error,
          ));
        },
      );
    });

    on<LoadMoreBooksEvent>((event, emit) async {
      if (state.status == HomeStatus.loading ||
          state.status == HomeStatus.loadingMore ||
          state.hasReachedMax) {
        return;
      }

      await ApiCall.call<BookModel>(
        path: ApiEndpoints.allList,
        method: ApiMethodType.get,
        queryParams: {
          'q': 'a',
          'startIndex': state.startIndex,
          'maxResults': 10,
          'key': FlavorConfig.apiKey,
        },
        fromJson: BookModel.fromJson,
        isLoading: (loading) {
          if (loading) {
            emit(state.copyWith(status: HomeStatus.loadingMore));
          }
        },
        onSuccess: (result) {
          final updatedBooks = [...state.books, ...result.items];
          emit(
            state.copyWith(
              status: HomeStatus.success,
              books: updatedBooks,
              startIndex: state.startIndex + result.items.length,
              hasReachedMax: result.items.length < 10,
              errorMessage: null,
              appException: null,
            ),
          );
        },
        onError: (error) {
          emit(state.copyWith(
            status: HomeStatus.failure,
            errorMessage: error.message,
            appException: error,
          ));
        },
      );
    });
  }
}
