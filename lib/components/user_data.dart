import 'package:flutter/foundation.dart';

class UserData with ChangeNotifier {
  String _name = "";
  int _booksRead = 0;
  String _favoriteGenre = "";
  String _bio = "";

  String get name => _name;
  int get booksRead => _booksRead;
  String get favoriteGenre => _favoriteGenre;
  String get bio => _bio;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setBooksRead(int booksRead) {
    _booksRead = booksRead;
    notifyListeners();
  }

  void setFavoriteGenre(String genre) {
    _favoriteGenre = genre;
    notifyListeners();
  }

  void setBio(String bio) {
    _bio = bio;
    notifyListeners();
  }
}
