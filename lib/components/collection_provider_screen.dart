import 'package:flutter/foundation.dart';
import '../model/book.dart';
import 'collection.dart';

class CollectionProvider with ChangeNotifier {
  Collection _collection = Collection();

  void addToCollection(Book book) {
    _collection.addToCollection(book);
    notifyListeners();
  }

  void removeFromCollection(Book book) {
    _collection.removeFromCollection(book);
    notifyListeners();
  }

  List<Book> getCollectionItems() {
    return _collection.getCollectionItems();
  }

  int getItemCount() {
    return _collection.getItemCount();
  }
}
