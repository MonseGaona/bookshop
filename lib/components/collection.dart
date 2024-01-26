import '../model/book.dart';

class Collection {
  List<Book> items = [];

  void addToCollection(Book book) {
    items.add(book);
  }

  void removeFromCollection(Book book) {
    items.remove(book);
  }

  List<Book> getCollectionItems() {
    return List.from(items);
  }

  int getItemCount() {
    return items.length;
  }
}
