abstract class SearchEvent {}

class FetchSearchResultsEvent extends SearchEvent {
  final String query;
  FetchSearchResultsEvent(this.query);
}

class LoadMoreSearchResultsEvent extends SearchEvent {
  final String query;
  LoadMoreSearchResultsEvent(this.query);
}
