// lib/favorite_manager.dart
class FavoriteManager {
  static final FavoriteManager _instance = FavoriteManager._internal();
  factory FavoriteManager() => _instance;

  List<String> favoriteItems = [];

  FavoriteManager._internal();
}
