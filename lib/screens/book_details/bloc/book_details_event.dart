sealed class BookDetailsEvent {}

class FetchBookDetailsEvent extends BookDetailsEvent {
  final String id;
  FetchBookDetailsEvent(this.id);
}
