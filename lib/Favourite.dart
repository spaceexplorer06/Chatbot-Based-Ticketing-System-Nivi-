import 'package:flutter/material.dart';
import 'favorite_manager.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text("Favourites"),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 182, 255, 184),
      body: _buildFavoriteList(),
    );
  }

  Widget _buildFavoriteList() {
    List<String> favorites = FavoriteManager().favoriteItems;

    if (favorites.isEmpty) {
      return const Center(
        child: Text(
          'No favorites yet!',
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            favorites[index],
            style: const TextStyle(fontSize: 18),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _removeFavorite(favorites[index]);
            },
          ),
        );
      },
    );
  }

  void _removeFavorite(String item) {
    setState(() {
      FavoriteManager().favoriteItems.remove(item);
    });
  }
}
